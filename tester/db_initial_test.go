package tester

import (
	"context"
	"testing"
	"time"

	sb "github.com/huandu/go-sqlbuilder"
	"github.com/jackc/pgx/v5"
	"github.com/stretchr/testify/require"
)

type TestStruct struct {
	ID               string  `db:"id"`
	Name             string  `db:"name"`
	Description      string  `db:"description"`
	NewField         string  `db:"new_field"`
	TestArrayOfArray [][]int `db:"test_array_of_array"`
	TestArrayOfInt   []int   `db:"test_array_of_int"`
}

type TestNewStruct struct {
	ID              string `db:"id"`
	TestTableID     string `db:"testtable_id"`
	Name            string `db:"name"`
	SampleNewColumn string `db:"sample_new_column"`
}

type TestMaterializedViewStruct struct {
	Data string    `db:"t_data"`
	Time time.Time `db:"t_time"`
}

var testBuilder = sb.NewStruct(new(TestStruct)).For(sb.PostgreSQL)
var materializedViewBuilder = sb.NewStruct(new(TestMaterializedViewStruct)).For(sb.PostgreSQL)
var testNewBuilder = sb.NewStruct(new(TestNewStruct)).For(sb.PostgreSQL)

func connectToDatabse(t *testing.T) *pgx.Conn {
	conn, err := pgx.Connect(context.Background(), "postgres://testuser:test1234@localhost:5832/test")
	require.NoError(t, err)

	return conn
}

func TestPostgresDatabaseInit(t *testing.T) {
	conn := connectToDatabse(t)
	defer conn.Close(context.Background())
}

func TestInsertAndGet(t *testing.T) {
	conn := connectToDatabse(t)

	// Insert a single row
	ib := testBuilder.InsertInto("testschema.testtable", TestStruct{
		ID:               "utest_id_1",
		Name:             "test",
		Description:      "test",
		NewField:         "default_value_new_field",
		TestArrayOfArray: [][]int{{1, 2, 3}, {4, 5, 6}},
		TestArrayOfInt:   []int{1, 2, 3},
	})

	sql, args := ib.Build()
	_, err := conn.Exec(context.Background(), sql, args...)
	require.NoError(t, err)

	conn.Close(context.Background())

	conn = connectToDatabse(t)

	// get the row
	sb := testBuilder.SelectFrom("testschema.testtable")
	sb.Where(sb.Equal("id", "utest_id_1"))
	sql, args = sb.Build()
	rows, err := conn.Query(context.Background(), sql, args...)
	require.NoError(t, err)
	if !rows.Next() {
		t.Fatal("no rows returned")
	}

	// scan row
	var testStruct TestStruct
	err = rows.Scan(testBuilder.Addr(&testStruct)...)

	// check data is same
	require.Equal(t, "utest_id_1", testStruct.ID)
	require.Equal(t, "test", testStruct.Name)
	require.Equal(t, "test", testStruct.Description)
	require.Equal(t, [][]int{{1, 2, 3}, {4, 5, 6}}, testStruct.TestArrayOfArray)
	require.Equal(t, []int{1, 2, 3}, testStruct.TestArrayOfInt)
	require.Equal(t, "default_value_new_field", testStruct.NewField)

	require.NoError(t, err)

	rows.Close()
	conn.Close(context.Background())

	// delete the row
	conn = connectToDatabse(t)
	defer conn.Close(context.Background())

	deleteBuilder := testBuilder.Flavor.NewDeleteBuilder()
	deleteBuilder.DeleteFrom("testschema.testtable")
	deleteBuilder.Where(deleteBuilder.Equal("id", "utest_id_1"))
	query, args := deleteBuilder.Build()

	_, err = conn.Exec(context.Background(), query, args...)
	require.NoError(t, err)
	conn.Close(context.Background())
}

func TestMaterializedViewGet(t *testing.T) {
	conn := connectToDatabse(t)
	defer conn.Close(context.Background())

	sb := materializedViewBuilder.SelectFrom("testschema.test_materialized_view")

	sql, args := sb.Build()
	rows, err := conn.Query(context.Background(), sql, args...)
	require.NoError(t, err)
	if !rows.Next() {
		t.Fatal("no rows returned")
	}

	var testMaterializedViewSTruct TestMaterializedViewStruct
	err = rows.Scan(materializedViewBuilder.Addr(&testMaterializedViewSTruct)...)
	require.NoError(t, err)

	require.Equal(t, "test_id_1test1test1", testMaterializedViewSTruct.Data)

	rows.Close()
}

func TestNewTableInsertAndGet(t *testing.T) {
	// First add a row on testtable
	conn := connectToDatabse(t)

	// Insert a single row
	ib := testBuilder.InsertInto("testschema.testtable", TestStruct{
		ID:               "utest_id_2",
		Name:             "test",
		Description:      "test",
		NewField:         "default_value_new_field",
		TestArrayOfArray: [][]int{{1, 2, 3}, {4, 5, 6}},
		TestArrayOfInt:   []int{1, 2, 3},
	})

	sql, args := ib.Build()
	_, err := conn.Exec(context.Background(), sql, args...)
	require.NoError(t, err)
	conn.Close(context.Background())
	conn = connectToDatabse(t)

	// Add a row on test_new_table owned by the row in the testtable
	ib = sb.NewStruct(new(TestNewStruct)).For(sb.PostgreSQL).InsertInto("testschema.test_new_table", TestNewStruct{
		ID:              "utest_id_1",
		TestTableID:     "utest_id_2",
		Name:            "test",
		SampleNewColumn: "test",
	})

	sql, args = ib.Build()
	_, err = conn.Exec(context.Background(), sql, args...)
	require.NoError(t, err)

	// Get the row from test_new_table
	sb := testNewBuilder.SelectFrom("testschema.test_new_table")
	sb.Where(sb.Equal("id", "utest_id_1"))
	sql, args = sb.Build()
	rows, err := conn.Query(context.Background(), sql, args...)
	require.NoError(t, err)
	if !rows.Next() {
		t.Fatal("no rows returned")
	}

	// scan row
	var testNewStruct TestNewStruct
	err = rows.Scan(testNewBuilder.Addr(&testNewStruct)...)
	require.NoError(t, err)

	// check data is same
	require.Equal(t, "utest_id_1", testNewStruct.ID)
	require.Equal(t, "utest_id_2", testNewStruct.TestTableID)
	require.Equal(t, "test", testNewStruct.Name)
	require.Equal(t, "test", testNewStruct.SampleNewColumn)

	rows.Close()
	conn.Close(context.Background())
	conn = connectToDatabse(t)

	// Delete the row from testtable
	deleteBuilder := testBuilder.Flavor.NewDeleteBuilder()
	deleteBuilder.DeleteFrom("testschema.testtable")
	deleteBuilder.Where(deleteBuilder.Equal("id", "utest_id_2"))
	query, args := deleteBuilder.Build()

	_, err = conn.Exec(context.Background(), query, args...)
	require.NoError(t, err)

	rows.Close()
	conn.Close(context.Background())
	conn = connectToDatabse(t)

	// Check deletion cacasded to test_new_table
	sb = testNewBuilder.SelectFrom("testschema.test_new_table")
	sb.Where(sb.Equal("id", "utest_id_1"))
	sql, args = sb.Build()
	rows, err = conn.Query(context.Background(), sql, args...)
	require.NoError(t, err)
	if rows.Next() {
		t.Fatal("row not deleted")
	}
}
