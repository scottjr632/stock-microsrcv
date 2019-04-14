package endpoints

import (
	"log"
	"stock-microsrvc-iris/models"
	"strings"
	"time"

	"github.com/go-pg/pg"
	"github.com/kataras/iris"
)

// EP type that will hold an initialized instance of all endpoints
type EP struct {
	db *pg.DB
}

// Build will return an initialized EP structure given the set parameters
func Build(DB *pg.DB) *EP {
	return &EP{
		db: DB,
	}
}

// Ping is a health check
func (e *EP) Ping(ctx iris.Context) {
	ctx.JSON(iris.Map{
		"status": "Running...",
	})
}

// GetStockPrice returns the price of a stock
func (e *EP) GetStockPrice(ctx iris.Context) {
	symbol := ctx.Params().Get("symbol")
	stock := &models.Stock{}

	if err := e.db.Model(stock).
		Where("symb  = UPPER(?)", strings.ToUpper(symbol)).
		Select(); err != nil {
		log.Println(err)
		ctx.StatusCode(iris.StatusInternalServerError)
		return
	}

	ctx.JSON(stock)

}

// GetStockHistory returns a list of stocks from days
func (e *EP) GetStockHistory(ctx iris.Context) {
	symbol := ctx.Params().Get("symbol")
	days, err := ctx.Params().GetInt("days")
	if err != nil {
		ctx.StatusCode(iris.StatusUnprocessableEntity)
	}

	now := time.Now()
	queryDate := now.AddDate(0, 0, -days)
	stocks := &[]models.StockHistoryMaster{}
	if err := e.db.Model(stocks).
		Where("symb = UPPER(?)", strings.ToUpper(symbol)).
		Where("time > ?", queryDate).
		Select(); err != nil {
		log.Println(err)
		ctx.StatusCode(iris.StatusInternalServerError)
	}

	ctx.JSON(stocks)
}

// GetAllStockSymbols returns a list of all stocks
func (e *EP) GetAllStockSymbols(ctx iris.Context) {
	stocks := &[]models.Stock{}
	if err := e.db.Model(stocks).
		Column("id", "symb", "price", "last_update").
		Select(); err != nil {
		log.Println(err)
		ctx.StatusCode(iris.StatusInternalServerError)
	}
	ctx.JSON(stocks)
}
