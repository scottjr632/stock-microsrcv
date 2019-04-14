package models

import "time"

// Stock represents a stocks table
type Stock struct {
	tableName struct{}  `sql:"stocks.stocks"`
	ID        int       `sql:"id" json:"id"`
	Symbol    string    `sql:"symb" json:"symbol"`
	Price     float64   `sql:"price"  json:"price"`
	Date      time.Time `sql:"last_update" json:"date"`
}

// StockHistoryMaster represents the master table for stocks
type StockHistoryMaster struct {
	tableName struct{}  `sql:"stocks.stock_history_master, alias:stockhistory"`
	ID        int       `sql:"id" json:"id"`
	Symbol    string    `sql:"symb" json:"symbol"`
	Price     float64   `sql:"price"  json:"price"`
	Date      time.Time `sql:"time" json:"date"`
}
