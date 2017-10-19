# Development Notes

## Use cases

- Given a specific url of property listings, will retrieve and store info about each listing
- Given a search criteria, will return listings that match

## Data model

Listing
- id
- title
- description
- mls (Multiple Listing System ID)
- url
- price
- acres
- latlong
- address
- city
- county
- state
- zip
- metadata_id

Photo
- listing_id
- url

Metadata
- favorite
- ignore
- notes

Categorizations
- listing_id
- category_id

Category
- name

## Search urls

http://www.landwatch.com/New_York_land_for_sale/Land?&px=100001
http://www.landandfarm.com/search/?StateIDs=42&MinAcreage=5&MaxPrice=100000&CurrentPage=1
http://nylandquest.com/results/?county=all&lower-price=0&upper-price=100000&lower-size=3&upper-size=all&category%5B%5D=bordering-state-land&category%5B%5D=country-acreage&category%5B%5D=farmland&category%5B%5D=land-and-cabin&category%5B%5D=land-with-mineral-rights&category%5B%5D=recreational-land&category%5B%5D=timberland&submit=Search
http://www.landfirstny.com/listings/category/Farms+-+Farmland/1
http://www.landwatch.com/default.aspx?ct=R&type=5,64;6,208;13,12;268,6843&r.PRIC=%2c129999&pg=3
http://www.landsofnewyork.com/new_york/land-for-sale/?excludefree=NO&includesurrounding=0&listingtype=1%2C2&lllat=40%2E2861267183&lllng=-75%2E6525488277&location=New%20York&pagenum=1&pricechange=0&propertytype=1%2C2%2C3%2C5%2C7&search=map&state_id=36&status=P%2CPP&unionsort=I%2EIsPremium%20DESC%2C%20I%2EPrice%20DESC&urlat=41%2E3420727935&urlng=-73%2E3783789059&zoomlevel=9&setURLL=false
http://www.timberlandproperties.net/catskillsrealestate/upstate-ny-land-by-number.php?link=image
