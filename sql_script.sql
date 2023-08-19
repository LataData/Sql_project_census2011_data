use project;
select Count(*) from project.info limit 5; #total number of rows
select count(*) from project.census limit 5; #total number of rows
select * from project.info where State in ('Jharkhand','Bihar') ; #dataset for jharkhand and bihar
select sum(population) from census; #population of India
#avg growth of each state
select state,avg(growth)*100 as average_growth from info group by state;
#top 3 states
select state,avg(growth)*100 as average_growth from info group by state 
order by average_growth desc limit 3;
#avg sex ratio of each state
select state,round(avg(sex_ratio),0) as avg_sex_ratio from info group by state order by avg_sex_ratio desc;
#avg literacy of each state
select state,round(avg(literacy),0) as avg_literacy from info group by state order by avg_li0teracy desc;
#state starting with a or b
select distinct state from census where lower(state) like 'a%' or lower(state) like 'b%';
#total literate population
select c.state ,round(sum(literate_population),0) as total_literate_population,
round(sum(illiterate_population),0) as total_illiterate_population from 
(select  a.district,a.state,(a.literacy/1000)*b.population as literate_population,
(1-a.literacy/1000)*b.population as illiterate_population  from
 info a inner join census b  on a.state=b.state and a.district=b.district ) c group by c.state;
 #Population of previous census
 select c.state ,round(sum(c.prev_census_population),0) as total_prev_population from ( select  a.district,a.state,b.population/(1+a.growth) as prev_census_population
 from
 info a inner join census b  on a.state=b.state and a.district=b.district) c group by c.state;
 #prev_population per km2
  select d.state,round((d.total_prev_population/d.total_area) ,0) as pop_per_unit_are from (select sum(c.area_km2) as total_area ,
  c.state ,round(sum(c.prev_census_population),0) as total_prev_population from 
  ( select b.area_km2 , a.district,a.state,b.population/(1+a.growth) as prev_census_population
 from
 info a inner join census b  on a.state=b.state and a.district=b.district) c group by c.state)d;
 #window function
 #top 3 districts of each state with highest literacy rate
 select a. district,a.state,a.rnk ,a.literacy from (select *,rank() over(partition by state order by literacy desc)
 as rnk from info )a where a.rnk in (1,2,3) order by a.state;
 
select * from census;




