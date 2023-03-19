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

type TestMaterializedViewStruct struct {
	Data string    `db:"t_data"`
	Time time.Time `db:"t_time"`
}

var userStruct = sb.NewStruct(new(TestStruct)).For(sb.PostgreSQL)
var materializedViewStruct = sb.NewStruct(new(TestMaterializedViewStruct)).For(sb.PostgreSQL)

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
	ib := userStruct.InsertInto("testschema.testtable", TestStruct{
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
	sb := userStruct.SelectFrom("testschema.testtable")
	sb.Where(sb.Equal("id", "utest_id_1"))
	sql, args = sb.Build()
	rows, err := conn.Query(context.Background(), sql, args...)
	require.NoError(t, err)
	if !rows.Next() {
		t.Fatal("no rows returned")
	}

	// scan row
	var testStruct TestStruct
	err = rows.Scan(userStruct.Addr(&testStruct)...)

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

	deleteBuilder := userStruct.Flavor.NewDeleteBuilder()
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

	sb := materializedViewStruct.SelectFrom("testschema.test_materialized_view")

	sql, args := sb.Build()
	rows, err := conn.Query(context.Background(), sql, args...)
	require.NoError(t, err)
	if !rows.Next() {
		t.Fatal("no rows returned")
	}

	var testStruct TestMaterializedViewStruct
	err = rows.Scan(materializedViewStruct.Addr(&testStruct)...)
	require.NoError(t, err)

	require.Equal(t, "test_id_1test1test1", testStruct.Data)

	rows.Close()
}
