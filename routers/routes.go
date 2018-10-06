package routers

import (
	"net/http"
	"stock-microsrvc/handlers"
)

type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

type Routes []Route

var routes = Routes{
	Route{
		"Index",
		"GET",
		"/",
		handlers.Index,
	},
	Route{
		"Stockprice",
		"GET",
		"/stock/price/{symbol}",
		handlers.GetStockPrice,
	},
	Route{
		"Test",
		"GET",
		"/user/info/{email}",
		handlers.GetUserInfo,
	},
	Route{
		"InsertStock",
		"POST",
		"/stock/{symbol}",
		handlers.InsertStock,
	},
    Route{
        "StockHistory",
        "GET",
        "/stock/history/{symbol}/{days}",
        handlers.GetStockHistory,
    },
}
