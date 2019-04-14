package server

import (
	"crypto/tls"
	"log"
	"os"

	"github.com/kataras/iris/middleware/logger"
	"github.com/kataras/iris/middleware/recover"

	"github.com/go-pg/pg"
	"github.com/kataras/iris"

	"stock-microsrvc-iris/endpoints"
)

// APIVERSION is the current version of the api
const APIVERSION = "v1"

// A Server struct contains all the information necessary to create a server
type Server struct {
	DB  *pg.DB
	API *endpoints.EP
	App *iris.Application
}

// Build returns a server after everything is built
func Build() *Server {
	srv := &Server{}

	srv.ConnectToDatabase()

	srv.BuildAPI()

	srv.BuildIris()

	return srv
}

// ConnectToDatabase establishes a connection to the database with the following credentials
func (s *Server) ConnectToDatabase() {
	dbUser := os.Getenv("DATABASE_USER")

	if dbUser == "" {
		log.Fatalln("No DATABASE_USER environment variable set")
	}

	dbPwd := os.Getenv("DATABASE_PASSWORD")

	if dbPwd == "" {
		log.Fatalln("No DATABASE_PASSWORD environment variable set")
	}

	dbURL := os.Getenv("DATABASE_URL")

	if dbURL == "" {
		log.Fatalln("No DATABASE_URL environment variable set")
	}

	dbName := os.Getenv("DATABASE_NAME")

	if dbName == "" {
		log.Fatalln("No DATABASE_NAME environment variable set")
	}

	dbTLS := os.Getenv("DATABASE_TLS")
	dbTLSServerName := os.Getenv("DATABASE_TLS_SERVER_NAME")
	dbTLSSkipVerify := false
	dbTLSDBCipher := false

	if dbTLS == "secure" {
		dbTLSSkipVerify = false
		dbTLSDBCipher = true
	} else if dbTLS == "secure-skip" {
		dbTLSSkipVerify = true
		dbTLSDBCipher = true
	} else if dbTLS == "insecure" {
		dbTLSSkipVerify = true
		dbTLSDBCipher = false
	}

	dbConnection := pg.Connect(&pg.Options{
		User:     dbUser,
		Password: dbPwd,
		Addr:     dbURL,
		Database: dbName,
	})

	if dbTLS == "secure" || dbTLS == "secure-skip" {
		dbConnection = pg.Connect(&pg.Options{
			User:     dbUser,
			Password: dbPwd,
			Addr:     dbURL,
			Database: dbName,
			TLSConfig: &tls.Config{
				ServerName:               dbTLSServerName,
				InsecureSkipVerify:       dbTLSSkipVerify,
				PreferServerCipherSuites: dbTLSDBCipher,
			},
		})
	}

	s.DB = dbConnection
}

//BuildAPI builds the endpoints as found below
func (s *Server) BuildAPI() {
	s.API = endpoints.Build(s.DB)
}

// BuildIris builds all the API endpoints
func (s *Server) BuildIris() {
	app := iris.New()

	app.Use(recover.New())
	app.Use(s.BuildLoggerLayer())

	api := app.Party("/api/" + APIVERSION)
	stock := api.Party("/stock")
	{
		stock.Get("/", s.API.GetAllStockSymbols)
		stock.Get("/{symbol}", s.API.GetStockPrice)
		stock.Get("/history/{symbol}/{days}", s.API.GetStockHistory)
	}

	ping := api.Party("/ping")
	{
		ping.Get("/", s.API.Ping)
	}

	s.App = app

}

// BuildLoggerLayer sets up the logger
func (s *Server) BuildLoggerLayer() iris.Handler {

	requestLogger := logger.New(logger.Config{
		Status: true,
		IP:     true,
		Method: true,
		Path:   true,
		Query:  true,

		MessageHeaderKeys: []string{"User-Agent"},
	})

	return requestLogger
}

// Run starts the server
func (s *Server) Run() {
	port := os.Getenv("STOCK_PORT")

	s.App.Run(iris.Addr(port))
}
