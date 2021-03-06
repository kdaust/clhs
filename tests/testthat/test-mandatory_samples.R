context("mandatory_samples")

test_that("Mandatory samples are actually selected (R)", {
  
  df <- data.frame(
    a = runif(1000), 
    b = rnorm(1000), 
    c = sample(LETTERS[1:5], size = 1000, replace = TRUE),
    stringsAsFactors = TRUE
  )
  
  mandatory_idx <- sample(1:nrow(df), size = 3)
  
  # no error
  res <- clhs(df, size = 10, iter = 100, use.cpp = F, must.include = mandatory_idx, progress = FALSE)
  expect_true(all(mandatory_idx %in% res))
  
  # error : size <= length(include)
  expect_error(clhs(df, size = 3, iter = 100, use.cpp = F, must.include = mandatory_idx, progress = FALSE))
  
})

test_that("Mandatory samples are actually selected (C++)", {
  
  df <- data.frame(
    a = runif(1000), 
    b = rnorm(1000), 
    c = sample(LETTERS[1:5], size = 1000, replace = TRUE),
    stringsAsFactors = TRUE
  )
  
  mandatory_idx <- sample(1:nrow(df), size = 3)
  
  
  # no error
  res <- clhs(df, size = 10, must.include = mandatory_idx)
  expect_true(all(mandatory_idx %in% res))
  
  # error : size <= length(include)
  expect_error(clhs(df, size = 3, iter = 5000, must.include = mandatory_idx))
  })

test_that("Samples are only from can.include (C++)", {
  
  df <- data.frame(
    a = runif(1000), 
    b = rnorm(1000), 
    c = sample(LETTERS[1:5], size = 1000, replace = TRUE),
    stringsAsFactors = TRUE
  )
  
  poss_idx <- sample(1:nrow(df), size = 600)
  
  # no error
  res <- clhs(df, size = 10, can.include = poss_idx)
  expect_true(all(res %in% poss_idx))

})


