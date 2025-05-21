package main

import (
	"bytes"
	_ "embed"
	"text/template"
)

//go:embed errorsTemplate.tpl
var errorsTemplate string

type errorInfo struct {
	Name       string
	Value      string
	HTTPCode   int
	CamelValue string
	Comment    string
	HasComment bool
	MsgKey     string
}

type errorWrapper struct {
	Errors []*errorInfo
}

func (e *errorWrapper) execute() string {
	tmpl, err := template.New("errors").Parse(errorsTemplate)
	if err != nil {
		panic(err)
	}
		panic(err)
	}
}
