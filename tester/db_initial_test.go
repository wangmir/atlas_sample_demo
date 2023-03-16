package tester

import (
	"context"
	"testing"

	sb "github.com/huandu/go-sqlbuilder"
	"github.com/jackc/pgx/v5"
	"github.com/stretchr/testify/require"
)

type TestStruct struct {
	ID               string  `db:"id"`
	Name             string  `db:"name"`
	Description      string  `db:"description"`
	TestArrayOfArray [][]int `db:"test_array_of_array"`
	TestArrayOfInt   []int   `db:"test_array_of_int"`
}

var userStruct = sb.NewStruct(new(TestStruct)).For(sb.PostgreSQL)

func connectToDatabse(t *testing.T) *pgx.Conn {
	conn, err := pgx.Connect(context.Background(), "postgres://testuser:test1234@localhost:5832/test")
	require.NoError(t, err)

	return conn
}

func TestPostgresDatabaseInit(t *testing.T) {
	conn := connectToDatabse(t)
	defer conn.Close(context.Background())
}

func TestPostgresDatabaseInsertAndGet(t *testing.T) {
	conn := connectToDatabse(t)

	// Insert a single row
	ib := userStruct.InsertInto("testschema.testtable", TestStruct{
		ID:               "test_id_1",
		Name:             "test",
		Description:      "test",
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
	sb.Where(sb.Equal("id", "test_id_1"))
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
	require.Equal(t, "test_id_1", testStruct.ID)
	require.Equal(t, "test", testStruct.Name)
	require.Equal(t, "test", testStruct.Description)
	require.Equal(t, [][]int{{1, 2, 3}, {4, 5, 6}}, testStruct.TestArrayOfArray)
	require.Equal(t, []int{1, 2, 3}, testStruct.TestArrayOfInt)

	require.NoError(t, err)

	rows.Close()
	conn.Close(context.Background())

	// delete the row
	conn = connectToDatabse(t)
	defer conn.Close(context.Background())

	deleteBuilder := userStruct.Flavor.NewDeleteBuilder()
	deleteBuilder.DeleteFrom("testschema.testtable")
	deleteBuilder.Where(deleteBuilder.Equal("id", "test_id_1"))
	query, args := deleteBuilder.Build()

	_, err = conn.Exec(context.Background(), query, args...)
	require.NoError(t, err)
}
