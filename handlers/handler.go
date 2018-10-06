package handlers

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"net/http"
	"stock-microsrvc/models"
)

type Hello struct {
	Message string `json:"message"`
}

/* Index handler function */
func Index(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	if err := json.NewEncoder(w).Encode(Hello{Message: "Hello, World!"}); err != nil {
		panic(err)
	}
}

func GetUserInfo(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	vars := mux.Vars(r)
	user := models.User{Email: vars["email"]}
	user.SetUserInfo()
	if err := json.NewEncoder(w).Encode(user); err != nil {
		panic(err)
	}
}

// TODO : Refractor over to another handler file for just stocks
func GetStockPrice(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	vars := mux.Vars(r)
	stock := models.Stock{Symbol: vars["symbol"]}
	_ = stock.GetStockDBPrice()
	if err := json.NewEncoder(w).Encode(stock); err != nil {
		panic(err)
	}
}

func InsertStock(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	vars := mux.Vars(r)
	stock := models.Stock{Symbol: vars["symbol"]}
	_ = models.InsertDBStock(&stock)
	if err := json.NewEncoder(w).Encode(Hello{Message: "stock inserted"}); err != nil {
		panic(err)
	}
}
