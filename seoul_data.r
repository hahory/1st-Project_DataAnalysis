crime=read.csv('C:/BigData/1차-프로젝트/data_set/서울시_구별_5대범죄발생(2016-2020).csv')
head(crime)
crime_cases<-crime[-1,c(1:3)]#불필요한 행,열들을 제거하기
names(crime_cases)<-c('연도','자치구','5대범죄 발생건수')#각 열의 이름 정하기
crime_cases<-crime_cases[!(crime_cases$자치구=='합계'),]#'합계'행들 제거하기
crime_cases<-crime_cases[crime_cases$연도=='2020',-1]#2020년에 해당하는 행만 남기고, 연도 열 삭제하기
as.numeric(crime_cases$발생건수)#데이터타입을 숫자로 변환
crime_cases$발생건수<-gsub(',','',crime_cases$발생건수) #숫자 쉼표 빼기
#데이터타입을 숫자로 변환
str(crime_cases)
crime_cases[order(crime_cases$발생건수)]
rownames(crime_cases)<-NULL
crime_cases
