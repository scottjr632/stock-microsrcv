package models

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq" // Blank because it is a necessary driver.
)

const (
	DB_USER     = "postgres"
	DB_PASSWORD = "postgres"
	DB_HOST     = "localhost"
	DB_NAME     = "postgres"
	DB_PORT     = "5432"
)

// DB database connection pool
var dbpool = createDB()

// executeQuery create a new Postgres DB insance and executes a query.
// It defers db.Close(). This method should only be used for executing
// querys and not executing any DML.
func executeQuery(db *sql.DB, query string, args ...interface{}) (*sql.Rows, error) {

	return db.Query(query, args...)
}

func getQueryRow(db *sql.DB, query string, args ...interface{}) *sql.Row {

	return db.QueryRow(query, args...)
}

// createDB creates a new postgres DB instance. `defer db.Close() is required
// if you use this function to create a new DB instance.
func createDB() *sql.DB {
	dbinfo, ok := os.LookupEnv("STOCK_DATABASE_URL")

	if !ok {
		dbinfo = fmt.Sprintf("user=%s password=%s dbname=%s port=%s host=%s sslmode=disable",
			DB_USER, DB_PASSWORD, DB_NAME, DB_PORT, DB_HOST)
	}

	db, err := sql.Open("postgres", dbinfo)
	if err != nil {
		log.Fatal("Cannot connect to database")
	}

	return db
}
