#install.packages("wordcloud")
#install.packages("Rfacebook")
library(Rfacebook)
library(wordcloud)
library(httpuv)


# token generated here: https://developers.facebook.com/tools/explorer 
token <- fbOAuth(app_id="xxxxxx", app_secret="xxxxxxx",extended_permissions = TRUE)

me <- getUsers("me", token, private_info = TRUE)
fix(me)

me$name # my name
me$hometown # my hometown
my_likes <- getLikes(user="me", token = token)
fix(my_likes)

fb_page1 <- getPage(page="109249609124014", token , since='2012/01/01', until='2014/12/22')

#wordcloud(fb_page$message , fb_page$comments_count)
wordcloud(fb_page1$message , fb_page1$comments_count)
wordcloud(fb_page1$message , fb_page1$likes_count)
#wordcloud(fb_page1$message , fb_page$likes_count)
fix(fb_page1)



