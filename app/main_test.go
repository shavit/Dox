package main

import (
  "testing"
)

func TestGeoApiShouldNotConnect(t *testing.T){
  var api GeoApi = NewGeoApi()

  if api.Connect("") == nil {
    t.Error("Should raise an error when connecting to invalid database uri")
  }
}
