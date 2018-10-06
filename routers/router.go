package routers

import (
    "net/http"
    "github.com/gorilla/mux"
    "stock-microsrvc/utils"
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
