cat('\014')

# Scrapes data from the Skycraper Center database, from the Council of Tall
# Buildings and Urban Habitat: http://www.skyscrapercenter.com/compare-data

##############
### Params ###
##############

# Links to each region's page of data.
# Cannot be too general with search params. If you want all completed buildings
# of any material or function, for all years and heights, then you have to
# specify a region in the search params.
# So we have to navigate to each region's search results and scrape those.
region_links = list(

  'Africa' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=5&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'Asia' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=7&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'Central America' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=3&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'Europe' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=1&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'Middle East' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=6&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'North America' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=2&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'Oceania' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=8&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results',

  'South America' = 'http://www.skyscrapercenter.com/compare-data/submit?type%5B%5D=building&status%5B%5D=COM&material%5B%5D=steel&material%5B%5D=concrete&material%5B%5D=composite&material%5B%5D=concrete%2Fsteel&material%5B%5D=steel%2Fconcrete&material%5B%5D=precast&material%5B%5D=masonry&function%5B%5D=office&function%5B%5D=residential&function%5B%5D=hotel&function%5B%5D=mixed-use&base_region=4&base_country=0&base_city=0&base_height_range=0&base_company=All&base_min_year=0&base_max_year=9999&comp_region=0&comp_country=0&comp_city=0&comp_height_range=4&comp_company=All&comp_min_year=0&comp_max_year=9999&skip_comparison=on&output%5B%5D=list&dataSubmit=Show+Results'

)


#############
### Setup ###
#############

suppressPackageStartupMessages({
  library(dplyr)
  library(janitor)
  library(readr)
  library(rvest)
  library(seleniumPipes)
})

source('./tbls_identical.R')

# Start Selenium.
# In terminal: sudo docker run -d -p 4445:4444 -p 5901:5900 selenium/standalone-chrome-debug
remDr = remoteDr(browserName = 'chrome', port = 4445L)


##############
### Scrape ###
##############

# Create list to hold the scraped data for each region.
region_tbls = vector(mode = 'list',
                     length = length(region_links))

# Could use lapply or purrr. I'll use loops so my logic is maximally legible.
for (i in 1:length(region_links)) {

  # Get link to region search results.
  home_url = region_links[[i]]

  # Navigate to them.
  remDr %>% go(home_url)

  message('Scraping data for ', names(region_links)[i])

  # "Home page" refers to the 1st page of the data table for a region.
  # "Current page" will be the page of the data table that we're currently
  # scraping.
  # Get source code for home page.
  current_page_src = home_page_src = remDr %>%
    seleniumPipes::getPageSource() %>%
    xml2::xml_child(2)

  # Find out how many pages of the data table we will scrape.
  # The URL of this site doesn't change when we turn pages of the data table,
  # so we have to track which page we're on by ourselves.
  num_paginates = home_page_src %>%
    rvest::html_nodes(css = 'span .paginate_button') %>%
    `[[`(length(.)) %>%
    rvest::html_text() %>%
    as.numeric()

  # Create list to hold scraped data for each page of the data table.
  query_tbls = vector(mode = 'list',
                      length = num_paginates)

  # Scrape all pages of the data table.
  for (j in 1:num_paginates) {

    message('Scraping paginate # ', j, ' of table.')

    # Get source code for current page of the data table.
    current_page_src = remDr %>%
      seleniumPipes::getPageSource() %>%
      xml2::xml_child(2)

    # Scrape current page of the data table.
    query_tbls[[j]] = current_page_src %>%
      rvest::html_nodes(css = '#table-baseList') %>%
      rvest::html_table() %>%
      `[[`(1)

    # Validate.
    if (j > 1) {

      if (identical(query_tbls[[j]], query_tbls[[j - 1]])) {
        stop('Table ', j, ' is identical to table ', (j + 1), '.')
      }

    }

    # Be nice.
    Sys.sleep(1)

    # Navigate to next page of the data table by clicking the "Next" button.
    # The web page's URL doesn't change, but the data in the table does.
    remDr %>%
      seleniumPipes::findElement(using = 'css selector',
                                 value = '#table-baseList_next') %>%
      seleniumPipes::elementClick()

    # Repeat.

  }

  # Validate.
  tbls_identical(query_tbls)

  query_tbls = query_tbls %>%
    lapply(janitor::remove_empty, which = 'cols') %>%
    lapply(mutate_all, .funs = as.character)

  # Combine data from all pages of current data table into one giant table.
  # Store in list.
  region_tbls[[i]] = dplyr::bind_rows(query_tbls)

  # Mark which region to which this data belongs.
  names(region_tbls)[i] = names(region_links)[i]

  # Be nice.
  Sys.sleep(1)

  # Repeat.

}

# Stop Selenium session.
remDr %>% seleniumPipes::deleteSession()

# We now have a table for each region. Combine them into one big table.
# Create new column, marking each record with the region to which it belongs.
all_tbl = dplyr::bind_rows(region_tbls,
                           .id = 'region')

all_tbl$timestamp = Sys.time()


##############
### Export ###
##############

write_csv(all_tbl,
          './data_skyscraper_center_CTBUH_2018-01-17.csv')
