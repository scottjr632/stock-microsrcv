package main

import (
    "fmt"
    "testing"
    "stock-microsrvc/models"
)

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
/*
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
