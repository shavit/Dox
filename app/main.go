package main

import (
  "fmt"
  "os"
  "database/sql"
  "strings"
)

type GeoApi interface {
  Connect(uri string) (err error)
  Close()
  Geocode(address string) (res geoAddress, err error)
}

type geoConnection struct {
  db *sql.DB
}

type geoAddress struct {
  Rating int `json: "rating"`
  Lon string  `json: "longtitude"`
  Lat string `json: "latitude"`
  Street string `json: "street"`
  City string `json: "city"`
  State string `json: "state"`
  Zip int64 `json: "zip"`
}

func NewGeoApi() GeoApi {
  return new(geoConnection)
}

func (g *geoConnection) Connect(uri string) (err error){
  g.db, err = sql.Open("postgres", uri)
  return err
}

func (g *geoConnection) Close(){
  g.db.Close()
}

func (g *geoConnection) Geocode(address string) (res geoAddress, err error) {
  var query string = fmt.Sprintf(`SELECT
      ST_X(g.geomout) As Lon,
      ST_Y(g.geomout) As Lat,
      COALESCE((addy).streetname, '') As Street,
      COALESCE((addy).location, '') As City,
      COALESCE((addy).stateabbrev, '') As State,
      (addy).zip AS Zip
    FROM geocode('%v') As g
    LIMIT 1`, address)

  err = g.db.QueryRow(query).Scan(
    &res.Lon,
    &res.Lat,
    &res.Street,
    &res.City,
    &res.State,
    &res.Zip)

  return res, err
}

func cli(){
  if len(os.Args) < 2 {
    panic("Missing address to geocode\n  Usage: cmd [address]")
  }

  var term string = strings.Join(os.Args[1:], " ")
  var err error
  var address geoAddress
  var api GeoApi = NewGeoApi()
  var databaseUri string
  var ok bool

  databaseUri, ok = os.LookupEnv("DATABASE_URI")
  if ok == false {
    panic("Environment key DATABASE_URI is not set")
  }

  api.Connect(databaseUri)
  defer api.Close()

  address, err = api.Geocode(term)
  if err != nil {
    panic(err)
  }

  println(address.Lon, address.Lat)
}

func main(){
  cli()
}
