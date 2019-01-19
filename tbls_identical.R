tbls_identical = function(tbls_list) {

  id = F

  for ( k in 1:(length(tbls_list) - 1) ) {

    if ( identical(tbls_list[[k]], tbls_list[[k + 1]]) ) {
      message('Table ', k, ' identical to table ', (k + 1), '.')
      id = T
    }

  }

  if (id == T) stop('Identical consecutive tables in list.')

  if (id == F) message('No two consecutive tables are identical.')

}
