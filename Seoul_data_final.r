#2020년 서울시 구별 면적당 5대범죄 발생수
crime=read.csv('crime_seoul_raw.csv')
head(crime)
crime<-crime[-1,c(1:3)]#불필요한 행,열들을 제거하기
names(crime)<-c('Year','District','Crime_cases')#각 열의 이름 정하기
crime<-crime[!(crime$District=='합계'),]#'합계'행들 제거하기
crime<-crime[crime$Year=='2020',-1]#2020년에 해당하는 행만 남기고, 연도 열 삭제하기
crime$Crime_cases<-gsub(',','',crime$Crime_cases) #숫자 쉼표 빼기
crime$Crime_cases<-as.numeric(crime$Crime_cases)#데이터타입을 숫자로 변환하기
str(crime)#데이터 타입 변환 확인하기
rownames(crime)<-NULL
crime
write.csv(crime,'crime_seoul.csv',row.names=TRUE)

area=read.csv('area_seoul_raw.csv',header = FALSE)
head(area)
area<-area[c(2,3)]
area<-area[-(1:3),]
names(area)<-c('District','Area')
rownames(area)<-NULL
head(area)
area$Area<-as.numeric(area$Area)
str(area)
write.csv(area,'area_seoul.csv',row.names=TRUE)

crime_area<-merge(crime, area)#District를 기준으로 두 데이터프레임을 합치기
crime_area$Crime_per_area<-cbind(round(crime_area$Crime_cases/crime_area$Area))#면적당범죄발생수를 열 추가
head(crime_area)
crime_area<-crime_area[,-c(2:3)]
head(crime_area)
write.csv(crime_area,'crime_seoul.csv',row.names=TRUE)

----------------------------------------------------------------------------------------------------------
#2022년 서울시 구별 면적당 유흥주점수
pub=read.csv('pub_seoul_raw.csv',fileEncoding='euc-kr')
head(pub)
str(pub)
pub<-pub[c(2,4)]#영업상태 열, 주소 열만 추출하기
head(pub)
names(pub)<-c('Store','District')#각 열의 이름 정하기
pub<-pub[!(pub$Store==2),]#'2(폐업)'행들 제거하기
head(pub)
str(pub)
#주소->구명으로 대체하기 위해 큰 방안의 두번째 작은 방을 추출하는 함수 만들기
#search<-function(x){
#    x[2]
#}
pub$District_split<-strsplit(pub$District, split=' ')
#search함수명을 sapply의 인자로 넣으면 x 인자가 누락되었다는 경고가 계속 뜸
#pub$District<-sapply(pub$District_split,search)
#sapply의 인자 자리에 함수 자제를 넣어줘야 함(함수 자체에 인자를 포함하고 있음)
pub$District<-sapply(pub$District_split,function(x){
    x[2]
})
head(pub)
pub<-pub[c(1,2)]
rownames(pub)<-NULL
pub<-aggregate(Store~District,pub,sum)#aggregate()는 데이터를 분할하고 각 그룹마다 요약치를 계산함
head(pub)
write.csv(pub,'pub_seoul.csv',row.names=TRUE)

area=read.csv('area_seoul_raw.csv',header = FALSE)
head(area)
area<-area[c(2,3)]
area<-area[-(1:3),]
names(area)<-c('District','Area')
rownames(area)<-NULL
head(area)
area$Area<-as.numeric(area$Area)
str(area)
write.csv(area,'area_seoul.csv',row.names=TRUE)

pub_area<-merge(pub, area)#District를 기준으로 두 데이터프레임을 합치기
pub_area$Pub_per_area<-cbind(round(pub_area$Store/pub_area$Area))#면적당업소수를 열 추가
head(pub_area)
pub_area<-pub_area[,-c(2:3)]
head(pub_area)
write.csv(pub_area,'pub_seoul.csv',row.names=TRUE)
