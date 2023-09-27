-- This script is useable for MySQL Server.alter

use PortfolioProject
-- WE are using Nashville_Housing table here

select * from Nashville_Housing

-- Lets start our cleaning proccess.
select PropertyAddress from Nashville_Housing

-- populate propery address
select PropertyAddress from Nashville_Housing where PropertyAddress is null
select *
 from Nashville_Housing where PropertyAddress is null

select *
 from Nashville_Housing order by ParcelID
 
 select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress 
 ,ifnull(b.PropertyAddress,a.PropertyAddress)
 from Nashville_Housing a join Nashville_Housing b on 
 a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID and b.PropertyAddress is null
 


 -- now updating the property address


update Nashville_Housing a
join Nashville_Housing b on a.ParcelID = b.ParcelID
set b.PropertyAddress = IFNULL(b.PropertyAddress, a.PropertyAddress)
where b.PropertyAddress is null
and a.UniqueID <> b.UniqueID
  
select PropertyAddress from Nashville_Housing 	-- Now this is not empty

-- Breaking out PropertyAddress column  into address ,city ,state
select substring(PropertyAddress,  locate(",", PropertyAddress)+ 1 ) as address
, substring(PropertyAddress, 1, locate(",", PropertyAddress) -1) as address
 from Nashville_Housing limit 10
 
-- creating column of  Property Addresses

alter table Nashville_Housing 
add column PropertySplitAddress nvarchar(255)

update  Nashville_Housing 
set PropertySplitAddress = substring(PropertyAddress, 1, locate(',', PropertyAddress) -1)


alter table Nashville_Housing 
add column PropertySplitcity nvarchar(255)

update  Nashville_Housing 
set PropertySplitCity = substring(PropertyAddress,  locate(",", PropertyAddress)+ 1) 

select PropertyAddress, PropertySplitCity, PropertySplitAddress from Nashville_Housing 

-- Owner address changing with parsename

select OwnerAddress from Nashville_Housing

select concat(OwnerAddress,",",3)
from Nashville_Housing

-- This code is for MS sql server--
SELECT PARSENAME(OwnerAddress, 1) AS part1,
       PARSENAME(OwnerAddress, 2) AS part2,
       PARSENAME(OwnerAddress, 3) AS part3,
       PARSENAME(OwnerAddress, 4) AS part4
FROM Nashville_Housing;
-- This code is for MS sql server--

SELECT 
    SUBSTRING_INDEX(OwnerAddress, ',', 1) AS OwnerSplitAddress,
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) AS OwnerSplitCity,
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 3), ',', -1) AS OwnerSplitState 
FROM Nashville_Housing
 -- creating new columns 
alter table Nashville_Housing add column OwnerSplitAddress nvarchar(255) 

alter table Nashville_Housing add column OwnerSplitCity nvarchar(255) 

alter table Nashville_Housing add column OwnerSplitState nvarchar(255) 
-- updating tables
update Nashville_Housing set
OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1) 

update Nashville_Housing set
OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)

update Nashville_Housing set
OwnerSplitState = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 3), ',', -1)

select OwnerSplitState, OwnerSplitCity,OwnerSplitAddress, OwnerAddress from Nashville_Housing

select distinct(soldAsVacant) from Nashville_Housing

select distinct(soldAsVacant), count(soldAsVacant) from Nashville_Housing
group by soldAsVacant order by 2

select soldAsVacant ,
case 
when soldAsVacant = 'Y' then 'Yes'
when soldAsVacant = 'N' then 'No'
else soldAsVacant
end as Fixed
from Nashville_Housing

update Nashville_Housing set soldAsVacant = 
case 
when soldAsVacant = 'Y' then 'Yes'
when soldAsVacant = 'N' then 'No'
else soldAsVacant
end;

-- Removing dublicate and using CTE

select *, 
row_number() 
over (
partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
order by UniqueID )as row_num
from Nashville_Housing order by ParcelID

with RowNumCTE as (
select *, 
row_number() 
over (
partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
order by UniqueID )as row_num
from Nashville_Housing) -- order by ParcelID
select * from RowNumCTE where row_num > 1 order by ParcelID


with RowNumCTE as (
select *, 
row_number() 
over (
partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
order by UniqueID )as row_num
from Nashville_Housing) -- order by ParcelID
delete from RowNumCTE where row_num > 1 

-- Deleting columns from table
alter table Nashville_Housing drop column PropertyAddress, drop column OwnerAddress, drop column TaxDistrict







