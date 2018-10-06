package handlers

import (
	"encoding/json"
	"net/http"
	"stock-microsrvc/models"
    "github.com/gorilla/mux"
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
	user := models.User{Email: "scottjr632@gmail.com"}
	user.SetUserInfo()
	if err := json.NewEncoder(w).Encode(user); err != nil {
		panic(err)
	}
}

func GetStockPrice(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
    vars := mux.Vars(r)
    stock := models.Stock{Symbol : vars["symbol"]}
    _ = stock.GetStockDBPrice()
    if err := json.NewEncoder(w).Encode(stock); err != nil {
		panic(err)
	}
}
