package main

import (
    "fmt"
    "testing"
    "stock-microsrvc/models"
)

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
