package models

import (
	"database/sql"
	"fmt"
	"os"
	"stock-microsrvc/utils"

	_ "github.com/lib/pq" // Blank because it is a necessary driver.
)

const (
	DB_USER     = "postgres"
	DB_PASSWORD = "postgres"
	DB_HOST     = "192.168.1.21"
	DB_NAME     = "testdb"
	DB_PORT     = "5434"
)

// executeQuery create a new Postgres DB insance and executes a query.
// It defers db.Close(). This method should only be used for executing
// querys and not executing any DML.
func executeQuery(query string) (*sql.Rows, error) {
	dbinfo := fmt.Sprintf("user=%s password=%s dbname=%s port=%s host=%s sslmode=disable",
		DB_USER, DB_PASSWORD, DB_NAME, DB_PORT, DB_HOST)
	db, err := sql.Open("postgres", dbinfo)
	utils.CheckErr(err)
	defer db.Close()

	return db.Query(query)
}

// createDB creates a new postgres DB instance. `defer db.Close() is required
// if you use this function to create a new DB instance.
func createDB() (*sql.DB, error) {
	dbinfo, ok := os.LookupEnv("STOCK_DATABASE_URL")

	if !ok {
		dbinfo = fmt.Sprintf("user=%s password=%s dbname=%s port=%s host=%s sslmode=disable",
			DB_USER, DB_PASSWORD, DB_NAME, DB_PORT, DB_HOST)
	}
	return sql.Open("postgres", dbinfo)
}
