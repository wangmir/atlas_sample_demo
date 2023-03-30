// can launch with atlas apply --env local
env "local" {
  // source schema file
  src = "./test_ddl.hcl"

  // target database url
  url = "postgres://testuser:test1234@localhost:5832/test?sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "docker://postgres/15"

  migration {
    // URL where the migration directory resides. Only filesystem directories
    // are currently supported but more options will be added in the future.
    dir = "file://migrations"
    // An optional format of the migration directory:
    // atlas (default) | flyway | liquibase | goose | golang-migrate | dbmate
    format = atlas
  }

  lint {
    latest = 1
  }

  format {
    migrate {
      diff = format(
        "{{ sql . \"  \" }}",
      )
    }
  }
}

lint {
  destructive {
    // By default, destructive changes cause migration linting to error
    // on exit (code 1). Setting `error` to false disables this behavior.
    error = false
  }
  // Custom logging can be enabled using the `format` attribute (previously named `log`).
  format = <<EOS
{{- range $f := .Files }}
    {{- json $f }}
{{- end }}
EOS
}

env "ci" {
  lint {
    git {
      base = "master"
      // An optional attribute for setting the working
      // directory of the git command (-C flag).
      dir = "<path>"
    }
  }
}
