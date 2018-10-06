package main

import (
	"fmt"
	"stock-microsrvc/models"
	"testing"
)

func TestHist(t *testing.T) {
    fmt.Println("Running test...")
    stock := models.NewStock("MU")
    stocks := stock.GetStockDBHistory(7)
    fmt.Println(stocks)
}

/*
func TestInsert(t *testing.T) {
	fmt.Println("Running test... ")
	stock := models.NewStock("ABCD")
	_ = models.InsertDBStock(stock)
	fmt.Println("Inserted")
}

func TestInsertFail(t *testing.T) {
	fmt.Println("Running test... ")
	stock := models.NewStock("ABCD")
	_ = models.InsertDBStock(stock)
	fmt.Println("Inserted")
}

func TestSelect(t *testing.T) {
   fmt.Println("Running test...")
   stock := models.NewStock("MU")
   price := stock.GetStockDBPrice()
   fmt.Println(*stock)
   fmt.Println(price)
}

func TestUpdate(t *testing.T) {
    fmt.Println("Running test...")
    stock := models.NewStock("MU")
    stock.UpdateDBPrice(10.12)
    fmt.Println(*stock)
}

*/
