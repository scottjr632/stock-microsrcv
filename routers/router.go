package routers

import (
	"net/http"
	"stock-microsrvc/utils"

	"github.com/gorilla/mux"
)

func NewRouter() *mux.Router {

	router := mux.NewRouter().StrictSlash(true)
	router = router.PathPrefix("/api/v1/").Subrouter()
	for _, route := range routes {
		var handler http.Handler

		handler = route.HandlerFunc
		handler = utils.Logger(handler, route.Name)
		router.
			Methods(route.Method).
			Path(route.Pattern).
			Name(route.Name).
			Handler(handler)

	}

	return router

}
