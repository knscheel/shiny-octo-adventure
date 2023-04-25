select * from merged

select * from ratesgrouped

select * from plansshort

select * from US_FIPS_Codes_rating_areasExcel

select * from RegionStatesExcel rse 

with dental as (
select distinct b.StateCode,
b.PlanId ,
b.BenefitName ,
b.CopayInnTier1 ,
b.CopayOutofNet ,
b.CoinsInnTier1 ,
b.CoinsOutofNet , 
b.IsCovered ,
b.LimitQty ,
b.LimitUnit ,
p.IssuerMarketPlaceMarketingName ,
p.MarketCoverage ,
p.PlanMarketingName ,
p.PlanType ,
p.DentalOnlyPlan ,
p.MetalLevel ,
p.ChildOnlyOffering ,
r.AgeGroup ,
AVG(r.IndividualRate) as AvgIndividualRate,
r.RatingAreaId 
from merged b
left join plansshort p on p.PlanId = b.PlanId 
inner join ratesgrouped r on r.PlanId  = b.StandardComponentId 
WHERE b.BenefitName LIKE '%Child%' and r.AgeGroup ='Under 14'
GROUP BY b.StateCode,b.PlanId ,b.StandardComponentId ,b.BenefitName ,b.CopayInnTier1 ,b.CopayOutofNet ,b.CoinsInnTier1 ,b.CoinsOutofNet , b.IsCovered ,
b.LimitQty ,b.LimitUnit ,b.Explanation ,p.IssuerMarketPlaceMarketingName ,p.MarketCoverage ,p.PlanMarketingName ,p.PlanType ,
p.DentalOnlyPlan ,p.MetalLevel ,p.ChildOnlyOffering ,r.AgeGroup,r.RatingAreaId 
ORDER BY b.StateCode , b.PlanId , r.RatingAreaId 
)
select * from dental


