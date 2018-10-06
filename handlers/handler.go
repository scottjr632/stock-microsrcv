package handlers

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"net/http"
	"stock-microsrvc/models"
    "strconv"
    "stock-microsrvc/utils"
)

type Hello struct {
	Message string `json:"message"`
}

// setJson is a helper function to set the header
// of the http.Response writer to json
func setJson(w http.ResponseWriter) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
    w.WriteHeader(http.StatusOK)
}

/* Index handler function */
func Index(w http.ResponseWriter, r *http.Request) {
    message := `<html><body><h3>Welcome to the stock api</h3><p>To use call</p>
                <p>/api/v1/stock/price/{symbol of stock}</p>
                <p>/api/v1/stock/history/{symbol of stock}/{history in days}</p>
                </html>`
    w.Write([]byte(message))
}

func GetUserInfo(w http.ResponseWriter, r *http.Request) {
	setJson(w)
	vars := mux.Vars(r)
	user := models.User{Email: vars["email"]}
	user.SetUserInfo()
	if err := json.NewEncoder(w).Encode(user); err != nil {
		panic(err)
	}
}

// TODO : Refractor over to another handler file for just stocks
func GetStockPrice(w http.ResponseWriter, r *http.Request) {
	setJson(w)
	vars := mux.Vars(r)
	stock := models.Stock{Symbol: vars["symbol"]}
	_ = stock.GetStockDBPrice()
	if err := json.NewEncoder(w).Encode(stock); err != nil {
		panic(err)
	}
}

func InsertStock(w http.ResponseWriter, r *http.Request) {
	setJson(w)
	vars := mux.Vars(r)
	stock := models.Stock{Symbol: vars["symbol"]}
	_ = models.InsertDBStock(&stock)
	if err := json.NewEncoder(w).Encode(Hello{Message: "stock inserted"}); err != nil {
		panic(err)
	}
}

func GetStockHistory(w http.ResponseWriter, r *http.Request) {
    setJson(w)
    vars := mux.Vars(r)
    days, err := strconv.Atoi(vars["days"])
    utils.CheckErr(err)
    stocks, err := models.NewStock(vars["symbol"]).GetStockDBHistory(days)
    if err != nil {
        json.NewEncoder(w).Encode(Hello{Message : "Something went wrong"})
        return
    }

    if err := json.NewEncoder(w).Encode(stocks); err != nil {
        json.NewEncoder(w).Encode(Hello{Message : "Something went wrong"})
    }
}






