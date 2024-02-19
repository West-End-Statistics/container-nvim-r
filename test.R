library(foreign)



test_function <- function(x = 1, y = 2) {

	x + y
}


httpgd::hgd(host = "0.0.0.0", port = 6543)
httpgd::hgd_url(host = "localhost")
