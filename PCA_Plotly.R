library(plotly)
data("iris")

X <- subset(iris, select = -c(Species))

prin_comp <- prcomp(X, rank. = 3)

components <- prin_comp[["x"]]
components <- data.frame(components)
components$PC2 <- -components$PC2
components$PC3 <- -components$PC3
components = cbind(components, iris$Species)

tot_explained_variance_ratio <- summary(prin_comp)[["importance"]]['Proportion of Variance',]
tot_explained_variance_ratio <- 100 * sum(tot_explained_variance_ratio)

tit = 'Total Explained Variance = 99.48'

#fig <- plot_ly() 
# fig <- fig %>% add_trace( ... )
# fig <- fig %>% layout( ... )

fig <- plot_ly(components, x = ~PC1, y = ~PC2, z = ~PC3, color = ~iris$Species, colors = c('#636EFA','#EF553B','#00CC96') ) %>%
  add_markers(size = 12)


fig <- fig %>%
  layout(
    title = tit,
    scene = list(bgcolor = "#ffffff")
  )

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

app <- Dash$new()
app$layout(
  htmlDiv(
    list(
      dccGraph(figure=fig)#,
      #dccGraph(figure=fig) 
    )
  )
)

app$run_server(debug=TRUE, dev_tools_hot_reload=FALSE)
