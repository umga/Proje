#=======================================================================================================
#======================    KAMAG Script on Energy Industries   =============================================
#                               Ummugulsum ALYUZ          
#                                 January 2016            
#=======================================================================================================
# GEREKLÝ DOSYALAR 

# 1. Chimney Data : KAMAG.R kodu ile olusturulmustur. 
# Tesis Adi / Il / Ilce / 
#TesisAdi/Il/Ilce /BacaAdi /BacaKodu / BacaNo /SnapKodu/ NfrKodu / BacaOlcumTarihi/ BacaCapi                    BacaCapiBirimi              BacaKesitAlani             
#BacaKesitAlaniBirimi / BacaYuksekligiYerden / BacaYuksekligiYerdenBirimi / BacaYuksekligiCatidan       BacaYuksekligiCatidanBirimi BacaAnmaIsilGuc            
#BacaAnmaIsilGucBirim / BacaYakitAdi / BacaYakitMiktar / BacaYakitMiktarBirim / BGH_1_mPERsec / BGH_3_mPERsec/BGH_ort_mPERsec/BK_1_m2                    
#BK_2_m2 / BK_3_m2 / BK_ort_m2 /BS_1_C / BS_2_C / BS_3_C /BS_ort_C / BB_1_mBar / BB_2_mBar /BB_3_mBar/BB_ort_mBar/CO2_1_Percent              
#CO2_2_Percent / CO2_3_Percent / CO2_ort_Percent /GBGD_1_m3PERh / GBGD_2_m3PERh /GBGD_3_m3PERh /GBGD_ort_m3PERh/KBGD_1_Nm3PERh/KBGD_2_Nm3PERh             
#KBGD_3_Nm3PERh / KBGD_ort_Nm3PERh / Nem_1_Percent /Nem_2_Percent/ Nem_3_Percent/Nem_ort_Percent/O2_1_Percent/O2_2_Percent /O2_3_Percent               
#O2_ort_Percent/YV_1_Percent/ YV_2_Percent/YV_3_Percent/YV_ort_Percent/ChimneyNumber/SO2_1_kgPERh/SO2_ort_kgPERh /SO2_1_mgPERnm3/SO2_2_mgPERnm3             
#SO2_3_mgPERnm3/ SO2_ort_mgPERnm3/ CO_1_kgPERh/CO_2_kgPERh/ CO_3_kgPERh/CO_ort_kgPERh/CO_1_mgPERnm3/CO_2_mgPERnm3/CO_3_mgPERnm3  CO_ort_mgPERnm3/NO_1_kgPERh                 NO_2_kgPERh                
#NO_3_kgPERh/NO_ort_kgPERh/NO_1_mgPERnm3 NO_2_mgPERnm3/NO_3_mgPERnm3/NO_ort_mgPERnm3/ NO2_1_kgPERh/     NO2_2_kgPERh/     NO2_3_kgPERh/    
#NO2_ort_kgPERh/ NO2_1_mgPERnm3/NO2_2_mgPERnm3/NO2_3_mgPERnm3/NO2_ort_mgPERnm3/ NOx_1_kgPERh/    
#NOx_2_kgPERh/NOx_3_kgPERh/  NOx_ort_kgPERh/NOx_1_mgPERnm3/NOx_2_mgPERnm3/NOx_3_mgPERnm3/  
#NOx_ort_mgPERnm3/ NOx_binded_1_mgPERnm3 /NOx_binded_2_mgPERnm3NOx_binded_3_mgPERnm3/NOx_ort_binded_mgPERnm3/NOx_binded_1_kgPERh        
#NOx_binded_2_kgPERh/NOx_binded_3_kgPERh/NOx_ort_binded_kgPERh Toz_1_mgPERnm3/ Toz_2_mgPERnm3/ Toz_3_mgPERnm3/  
#Toz_ort_mgPERnm3/Toz_Aciklama_mgPERnm3/Toz_1_kgPERh/ Toz_2_kgPERh/Toz_3_kgPERh/Toz_ort_kgPERh/  
#Toz_Aciklama_kgPERh /VOC_1_mgPERnm3/VOC_2_mgPERnm3/VOC_3_mgPERnm3/VOC_ort_mgPERnm3/VOC_Aciklama_mgPERnm3      
#VOCKutleselDebiOlcum1/VOCKutleselDebiOlcum2/VOCKutleselDebiOlcum3 / VOCKutleselDebiOlcumOrt/VOCKutleselDebiOlcumAdi    

# 2. SNAP NFR LIST of EMEP Guidebook 
# NFR  / NFR_Explanation  / SNAP	/ SNAP_Explanation	/ Fuel	/ Technology	/ Abatement_Tech	
#Pollutant	/ EF	/ Unit	/ X95_Perc_conf_Int_Lower	/ X95_Perc_conf_Int_Upper/ 	Tier	/ Table_No

setwd("C:/Users/ummugulsum.alyuz/Google Drive/KAMAG/R")
#setwd("/Users/burakoztaner1/Desktop/Ummugulsum")
ChimneyData <- read.csv2("ChimneyData.txt", 
                         sep="", quote="\"", header=T) # read by skipping first line 

Plants = ChimneyData[!duplicated(ChimneyData$TesisAdi), c(1:3, 9, 63)] # Butun tesisler hk. genel bilgi 


#PREPARE ENERGY DATASET 
Energy = ChimneyData[grep("ENERJI*|ELEKT*|KOMBINE*|CEVRIM*", ChimneyData$TesisAdi), ] 
Energy2 = ChimneyData[grep("1.A.1.*", ChimneyData$NfrKodu), ]
Energy=rbind(Energy, Energy2)
Energy=Energy[- grep("2.*", Energy$NfrKodu),] # Nfr kodu 2 ile baslayanlari cikart
TesisBilgileri_Energy = Energy[!duplicated(Energy$TesisAdi), c(1:3, 9, 63)] #Yalniz tesis isimleri listesi

Fark = ChimneyData[-grep("ENERJI*|ELEKT*", ChimneyData$TesisAdi), ] #Enerji olmayan tesisleri ayir
Fark = Fark[-grep("2.*", Fark$NfrKodu), ]
TesisBilgileri_Fark = Fark[!duplicated(Fark$TesisAdi), ]

rm(Energy2, Fark, TesisBilgileri_Fark)
Energy = Energy[!duplicated(Energy), ] # remove duplicated rows 
colnames(Energy)[which(colnames(Energy) %in% c("SnapKodu", "NfrKodu", "BacaYakitAdi"))] = c("SNAP_P", "NFR_P", "Fuel_P")




# Yukaridaki enerji bacalari bir excele kaydedilir, sonra yanýna aþaðýdaki kolonlar yazýlarak doldurulur ve "AktiviteVerileri.csv" adýyla kaydedilir. 

# PREPARE ACTIVITY DATASET
ActivityData  <- read.table("AktiviteVerileri.csv",sep=";",  header=T) # KESME ISARETI VARSA KALDIR! csv okumuyor. 
#TesisAdi / Il / BacaAdi /	BacaKodu /	BacaNo	/ BacaAnmaIsilGuc_P	/ BacaAnmaIsilGucBirim_P	/ 
#BacaYakitAdi_P	/ BacaYakitMiktar_P	/ BacaYakitMiktarBirim_P	/ SnapKodu	/ NfrKodu	/ Table_No	/ YillikCalismaGunu	/ GunlukCalismaSaati
#BacaYakitMiktari	/ YakýtTuru	/ YakitMiktariBirimi	/ CaloriphicValue	/ CaloriphicValueUnit	/ TesisYakitMiktari	/ TesisYakitMiktariBirimi	/ UretilenEnerjiBirim	/ UretilenEnerji
levels(ActivityData$NfrKodu)
library(plyr)
ActivityData$NfrKodu = revalue(ActivityData$NfrKodu, c("1.A.4.a.i" = "1.A.4.A.I", 
                                                       "1.A.2.b" = "1.A.2.B", 
                                                       "1.A.1.a" = "1.A.1.A", 
                                                       "1.A.2.f.i" = "1.A.2.F.I"))
levels(ActivityData$NfrKodu)

names(ActivityData) # dikkat! asagidaki kod kullanýlýrken degiskenlerin siralamasi datasette oldugu gibi verilmeli! En son dogru atanmissa tekrar kontrole edilmeli.
colnames(ActivityData)[which(colnames(ActivityData) %in% c("NfrKodu", "SnapKodu", "Table_No", "BacaYakitMiktari", "YakýtTuru"))] = c("NFR_AD", "SNAP_AD", "Table_No_AD", "Fuel_Amount_AD", "Fuel_AD") # dikkat! bu kod kullanýlýrken degiskenlerin siralamasi datasette oldugu gibi verilmeli! En son dogru atanmissa tekrar kontrole edilmeli. 

# READ SNAP NFR LIST OF EMEP---------------------------------------------
#EF birimine karar verebilmek icin corresponding EMEP EF lerinin aktarýlmasý 
SNAP_NFR_List  <- read.table("EMEP_Guidebook_SNAP_NFR_List.csv",sep=";",  header=T)
SNAP_NFR_List = SNAP_NFR_List[!duplicated(SNAP_NFR_List), ] # remove duplicated rows 

names(SNAP_NFR_List) # dikkat! asagidaki kod kullanýlýrken degiskenlerin siralamasi datasette oldugu gibi verilmeli! En son dogru atanmissa tekrar kontrole edilmeli.
colnames(SNAP_NFR_List)[which(colnames(SNAP_NFR_List) %in% 
                                c("NFR","NFR_Explanation", "SNAP", "SNAP_Explanation" , "Fuel", "Technology", "Abatement_Tech", "Pollutant", "EF", "Unit", "X95_Perc_conf_Int_Lower","X95_Perc_conf_Int_Upper", "Table_No") )] <- 
  c("NFR_EMEP","NFR_Explanation_EMEP", "SNAP_EMEP", "SNAP_Explanation_EMEP" , "Fuel_EMEP", "Technology_EMEP", "Abatement_Tech_EMEP", "Pollutant_EMEP", "EF_EMEP", "EF_Unit_EMEP", "X95_Perc_conf_Int_Lower_EMEP","X95_Perc_conf_Int_Upper_EMEP", "Table_No_EMEP") # change colnames

# EMEP List icinde SO2 ve SOx gibi kirleticilerin birlestirilmesi
levels(SNAP_NFR_List$Pollutant)
library(plyr)
revalue(SNAP_NFR_List$Pollutant, c("SO2" = "SOx", 
                                   "Sox" = "SOx")) -> SNAP_NFR_List$Pollutant_merged
levels(SNAP_NFR_List$Pollutant_merged)

levels(SNAP_NFR_List$NFR_EMEP)
SNAP_NFR_List$NFR_EMEP = revalue(SNAP_NFR_List$NFR_EMEP, c("1.A.1.a" = "1.A.1.A", 
                                                           "1.A.1.b" = "1.A.1.B", 
                                                           "1.A.1.c" = "1.A.1.C", 
                                                           "1.A.2.a" = "1.A.2.A", 
                                                           "1.A.2.b" = "1.A.2.B", 
                                                           "1.A.2.f.i" = "1.A.2.F.I", 
                                                           "1.A.4.a.i" = "1.A.4.A.I", 
                                                           "1.A.4.b.i" = "1.A.4.B.I", 
                                                           "1.A.4.c.i" = "1.A.4.C.I", 
                                                           "1.A.5.a" = "1.A.5.A"))
levels(SNAP_NFR_List$NFR_EMEP)

# islemleri kolaylastirmasi icin NFR SNAP Table_No sutunlari icerigi birlestirilmeli
SNAP_NFR_List[SNAP_NFR_List==""]<- NA # for converting blank cells to NA
SNAP_NFR_List$Index_EMEP=paste(SNAP_NFR_List$NFR_EMEP, SNAP_NFR_List$SNAP_EMEP, SNAP_NFR_List$Table_No_EMEP, sep="_")



# Obtain Final MERGED Energy Dataset --------------------------------
names(Energy)
names(SNAP_NFR_List)
names(ActivityData)

#merge with actvitiy data of each chimney 
Energy= data.frame(Energy, ActivityData[match(Energy$BacaAdi, ActivityData$BacaAdi, Energy$TesisAdi, ActivityData$TesisAdi), 11:24])
names(Energy)
x=subset(Energy, select=c(TesisAdi, BacaAdi, SNAP_P, NFR_P, SNAP_AD, NFR_AD))
summary(x) # dikkat; Muhammed Aktivite verilerini yazarken bazi bacalarin SNAP NFR kodunu guncellemis. Yeni olanlarý al. 
Energy <- subset(Energy, select=-c(SNAP_P, NFR_P)) # remove SNAP NFR of Portal
rm(x)

# islemleri kolaylastirmasi icin NFR SNAP Table_No sutunlari icerigi birlestirilmeli
Energy[Energy==""]<- NA # for converting blank cells to NA
Energy$Index_AD=paste(Energy$NFR_AD, Energy$SNAP_AD, Energy$Table_No_AD, sep="_")

# ADAPAZARI ELEKTRIK URETIM LTD. STI. = GEBZE ELEKTRIK URETIM LTD.STI oldugu icin ve EIR'de Adapazarý seklinde verildigi icin; 
Energy = Energy[grep("GEBZE*", Energy$TesisAdi, invert=TRUE), ]

# Energy Production (1.A.1) olmayan bacalarin elenmesi 
Energy_all = Energy
Energy=Energy_all[grep("1.A.1.A.*", Energy_all$NFR_AD), ]
Plants_Energy = Energy[!duplicated(Energy$TesisAdi), c(1:2)] #Yalniz tesis isimleri listesi

# ! DÝKKAT!  
# Aktivite verilerinde NA ise envanter hesabýnda da NA hesaplýyor. Bu nedenle aktivite verilerindeki NA satirlarin doldurulmasi gerekiyor. 
# Caloriphic Value 

# YillikCalismaGunu
Energy$YillikCalismaGunu[is.na(Energy$YillikCalismaGunu)] <- mean(Energy$YillikCalismaGunu, na.rm=TRUE)
# GunlukCalismaSaati
Energy$GunlukCalismaSaati[is.na(Energy$GunlukCalismaSaati)] <- mean(Energy$GunlukCalismaSaati, na.rm=TRUE)
# Fuel_Amount_AD   :  No replace 



#=========================================================
#             CALCULATE EMISSION FACTORS
#=========================================================


# SO2 EFs ------------------------------------------------
names(Energy)
SO2= cbind(Energy[ , c(1:9, 61, 41:48, 16:20)], 
           Energy[ , grepl( "SO2_*" , names( Energy), ignore.case=FALSE)], 
           Energy[, (((ncol(Energy))-14):ncol(Energy))])

#match EMEP guidebook EF unit
SNAP_NFR_List_SO2=subset(SNAP_NFR_List, Pollutant_merged=="SOx")

SO2= data.frame(SO2,
                SNAP_NFR_List_SO2[match(SO2$Index_AD, SNAP_NFR_List_SO2$Index_EMEP), ])

Derli_Toplu=subset(SO2, select=c("TesisAdi", "BacaAdi", "NFR_AD", "SNAP_AD", "Table_No_AD", "Index_AD", "Index_EMEP", "Fuel_P", "Fuel_AD", "Fuel_EMEP", "Pollutant_merged")) # daha derli toplu gorebilmek icin 

SO2 = SO2[grep("1.A.1.A.*", SO2$NFR_AD), ]
Derli_Toplu=subset(SO2, select=c("TesisAdi", "BacaAdi", "NFR_AD", "SNAP_AD", "Table_No_AD", "Index_AD", "Index_EMEP", "Fuel_P", "Fuel_AD", "Fuel_EMEP", "Pollutant_merged")) # daha derli toplu gorebilmek icin 
rm(TesisBilgileri_Energy, SNAP_NFR_List_SO2)

#SO2$Index_EMEP[is.na(SO2$Index_EMEP)] = ""
#SO2$Index_EMEP[SO2$Index_EMEP=='NA'] <- NA
#Problemli_Bacalar=subset(Derli_Toplu, Index_EMEP == " ") # problemli olan bacalarin belirlenmesi, daha sonra bunlar elle excele donerek guncellenmeli
# "AktiviteVerileri.csv" dosyasini acarak problemli SNAP / NFR / Table_No deðiþtir. 
# Ayrica "Derli_Toplu" isimli dosyada "INDEX_AD"  "INDEX_EMEP" isimli kolonlarin ayni oldugunu gozle kontrol et, boyellikle SNAP/NFR'ý hatali olanalri belirle, "AktiviteVerileri.csv" dosyasinda guncelle. 
# Yukarýya kadar olan kodu tekrardan run et. Problemli_Bacalar içerisinde sadece SNAP/NFR atanmamis olanlar kalmali. 
# Ustelik bazi bacalarin kodlarini da guncellemis olabilirim. Bu durumda enerji icinde olmayan kodlari exclude etmeliyim; 

# convert factor columns to numeric in order to enable arithmetics
str(SO2)
unfactorize<-c((colnames(SO2[ , grepl( "SO2_*" , colnames(SO2))])), # list of colnames starting with SO2 
               (colnames(SO2[ , grepl( "KBGD_*" , colnames(SO2))])), 
               "Fuel_Amount_AD", "CaloriphicValue")
SO2[,unfactorize]<-lapply(unfactorize, function(x) as.numeric(as.character(SO2[,x])))
rm(unfactorize)
