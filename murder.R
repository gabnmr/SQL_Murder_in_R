install.packages("dplyr")
library(dplyr)

#--------------------------- informações sobre o caso----
cs <- read.csv(
  "/cloud/project/dados/crime_scene_report.csv")
View(cs)

casosData <- cs$date == 20180115
casosCid <- cs$city == "SQL City"
casosTipo <- cs$type == "murder"

condicoes <- casosData & casosCid & casosTipo

casos <- filter(cs,condicoes)
View(casos)

casos$description

#--------------------------- testemunhas----
prsn <- read.csv(
  "/cloud/project/dados/person.csv")
View(prsn)

w1 <- filter(prsn,address_street_name == "Northwestern Dr")
w1 <- w1[which.max(w1$address_number),]
w1

w2 <- filter(prsn,address_street_name == "Franklin Ave")
w2 <- w2[grep(pattern = "Annabel",w2$name),]
w2

#--------------------------- entrevistas das testemunhas----
inter <- read.csv(
  "/cloud/project/dados/interview.csv")
View(inter)

w1_inter <- filter(interview,person_id == w1$id)
w1_inter

w2_inter <- filter(interview,person_id == w2$id)
w2_inter

#--------------------------- dados da academia----
#w1----
gym_member <- read.csv(
  "/cloud/project/dados/get_fit_now_member.csv")
View(gym_member)

s1 <- gym_member[grep(pattern = "48Z",gym_member$id),] %>%
  filter(membership_status == "gold")

s1

s2 <- s1[2,]
s2
s1 <- s1[1,]
s1

drivers <- read.csv(
  "/cloud/project/dados/drivers_license.csv")
View(drivers)

plate <- drivers[grep(pattern = "H42W",drivers$plate_number),]
plate <- filter(plate,gender == "male")
plate

carro1 <- plate[1,]
carro2 <- plate[2,]


#carros----
#carro1----

s2_car <- prsn[prsn$license_id == carro1$id,]
s2_car

culpado1 <- s2_car

#carro2----

s1_car <- prsn[prsn$license_id == carro2$id,]
s1_car


#w2-----
gym_in <- read.csv(
  "/cloud/project/dados/get_fit_now_check_in.csv")
View(gym_in)

#todos do dia
gym_in <- filter(gym_in,check_in_date == 20180109)
gym_in <- gym_in[grep(pattern = "48Z",gym_in$membership_id),]
gym_in

gym_in1 <- gym_in[1,]
gym_in2 <- gym_in[2,]


s1_id1 <- gym_member[gym_member$id == gym_in1$membership_id,]
s1_id1

s1_id2 <- gym_member[gym_member$id == gym_in2$membership_id,]
s1_id2


#entrevistas----
interview <- read.csv(
  "/cloud/project/dados/interview.csv")
View(interview)

facebook <- read.csv(
  "/cloud/project/dados/facebook_event_checkin.csv")
View(facebook)


#carro 1

interview[interview$person_id == s2_car$id,]

s2_id <- drivers %>% filter(hair_color == "red") %>% 
  filter(car_make == "Tesla") %>%
  filter(gender == "female") %>%
  filter(between(height,65,67)) %>%
  select(id)

s2_id1 <- prsn[prsn$license_id == s2_id$id[1],]
s2_id1

s2_id2 <- prsn[prsn$license_id == s2_id$id[2],]
s2_id2

s2_id3 <- prsn[prsn$license_id == s2_id$id[3],]
s2_id3

concert <- facebook[grep(pattern = "201712",facebook$date),] %>% 
  filter(event_name == "SQL Symphony Concert") %>%
  group_by(person_id) %>%
  filter(n() == 3)

concert <- data.frame(count(concert))

culpado2 <- prsn[prsn$id == concert$person_id,]

#carro 2

interview[interview$person_id == s1_car$id,]



#CULPADOS----
culpado1
culpado2
