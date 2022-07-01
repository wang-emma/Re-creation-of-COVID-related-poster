library(grid)

grid.newpage()

# Title object
title <- textGrob("COVID-19 vaccine:", x = 0, gp = gpar(fontsize = 18), 
                  just = "left")

# Subtitle object
subtitle <- textGrob("Estimated volumes and timing of vaccine rollout", 
                     x = 0, just = "left",
                     gp = gpar(fontsize = 18, fontface = "bold"))

# caption object
caption <- textGrob("This illustration shows planned DHB vaccine dose delivery to 30 June 2020. It then shows the\nprojected increased vaccine delivery required to offer two doses of the vaccine to everyone in\nNew Zealand aged 16 or over before the end of the year. Please note, it does not assume a\n specific acceptance level.", 
                    x = 0, gp = gpar(fontsize = 8), just = "left")


# A layout of 6*3
layout <- grid.layout(nrow = 6, ncol = 3, 
                      widths = unit(c(3, 1, 3), c("cm", "null", "cm")),
                      height = unit.c(grobHeight(title) + unit(4, "mm"),
                                      grobHeight(subtitle) + unit(4, "mm"), 
                                      grobHeight(caption) + unit(4, "mm"), 
                                      unit(c(0.25, 1, 0.5), 
                                           c("in", "null", "in"))))
# Push the layout
pushViewport(viewport(width = unit(1, "npc") - unit(2, "cm"),
                      height = unit(1, "npc") - unit(2, "cm"), 
                      layout = layout))


# 1st row
pushViewport(viewport(layout.pos.row = 1))
grid.draw(title)

# 2nd row
popViewport(n = 1)
pushViewport(viewport(layout.pos.row = 2))
grid.draw(subtitle)

# 3rd row
popViewport(n = 1)
pushViewport(viewport(layout.pos.row = 3))
grid.draw(caption)



# 5th row, 2nd column
popViewport(n = 1)
pushViewport(viewport(layout.pos.row = 5, layout.pos.col = 2, 
                     yscale = c(0, 9.5e6), xscale = c(0, 9)))

# Fill in the plotting region
grid.rect(gp = gpar(fill = purple1, col = NA))

# Curve before June
grid.xspline(x = unit(curve$x[1:7], "native"), y = unit(curve$y[1:7], "native"),
             shape = rep(-1, 7), gp = gpar(col = purple8))

# Filled area under the curve
grid.xspline(x = unit(c(0, curve$x[1:7], curve$x[7]), "native"), 
             y = unit(c(0, curve$y[1:7], 0), "native"), open = F,
             shape = c(0, 0, rep(-1, 5),0, 0), 
             gp = gpar(fill = purple3, col = NA))

# Curve after June
grid.xspline(x = unit(curve$x[7:19], "native"), 
             y = unit(curve$y[7:19], "native"), shape = rep(-1, length(7:19)), 
             gp = gpar(col = purple8, lty = "dashed"))

# Filled area under the curve
tile <- pattern(linesGrob(x = c(0, 1), y = c(0, 1), 
                             gp = gpar(col = purple4)), 
                width = 0.02, height = 0.02, extend = "repeat")

grid.xspline(x = unit(c(curve$x[7], curve$x[7:19], curve$x[19]), "native"), 
             y = unit(c(0, curve$y[7:19], 0), "native"), open = F,
             shape = c(0, 0, rep(-1, length(7:19)-2),0, 0), 
             gp = gpar(fill = tile, col = NA))



# Vertical lines for axis
grid.segments(x0 = c(0,1), y0 = 0, x1 = c(0,1), y1 = 1, 
              gp = gpar(col = purple5))

# Line at bottom
grid.segments(x0 = 0, y0 = 0, x1 = 1, y1 = 0, 
              gp = gpar(col = purple7, lwd = 4, lineend = "butt"))


# Vertical lines
grid.segments(x0 = unit(c(1,3), "native"), y0 = 0, 
              x1 = unit(c(1,3), "native"), y1 = unit(c(4e6, 6e6), "native"), 
              gp = gpar(col = purple5))

# Rounded rectangles
grid.roundrect(x = unit(1, "native") + unit(2, "mm"), 
               y = unit(4e6, "native"), 
               width = unit(2, "cm"), height = unit(1, "cm"),
               gp = gpar(fill = purple3, col = NA), 
               just = c("left", "top"))

grid.roundrect(x = unit(3, "native") + unit(2, "mm"), 
               y = unit(6e6, "native"), 
               width = unit(2, "cm"), height = unit(1, "cm"),
               gp = gpar(fill = purple3, col = NA), 
               just = c("left", "top"))

# Annotation for vaccination group
ann1 <- textGrob("Vaccinating Group 1 and 2\nnow and ongoing", 
                 x = unit(4, "mm"), y = unit(1, "npc") - unit(4, "mm"), 
                 just = c("left", "top"), gp = gpar(fontsize = 8))

grid.roundrect(x = unit(2, "mm"), y = unit(1, "npc") - unit(2, "mm"), 
               width = grobWidth(ann1) + unit(4, "mm"), 
               height = grobHeight(ann1) + unit(4, "mm"),
               gp = gpar(fill = purple3, col = NA), 
               just = c("left", "top"))
grid.draw(ann1)


# Circle and number
grid.circle(x = unit(5, "mm"), r = unit(3, "mm"), 
            y = unit(1, "npc") - grobHeight(ann1) - unit(11, "mm"), 
            gp = gpar(col = NA, fill = purple7))

grid.text(1, x = unit(5, "mm"), r = unit(3, "mm"), 
          y = unit(1, "npc") - grobHeight(ann1) - unit(11, "mm"), 
          gp = gpar(fontface = "bold", fontsize = 8))

# Border annotation
grid.text("Border and MIQ\nworkers, and the\npeople they live with", 
          x = unit(10, "mm"), 
          y = unit(1, "npc") - grobHeight(ann1) - unit(8, "mm"), 
          just = c("left", "top"), gp = gpar(fontsize = 8))


# Another Viewport
popViewport(n = 1)
pushViewport(viewport(layout.pos.row = 5, layout.pos.col = 1,
                      # Create a scale
                      yscale = c(0, 9.5e6)))

y_pos <- 0:8 * 1e6
# Tick marks on y-axis
grid.segments(x0 = unit(1, "npc") - unit(4, "mm"), y0 = unit(y_pos, "native"),
              x1 = unit(1, "npc") - unit(2, "mm"), y1 = unit(y_pos, "native"), 
              gp = gpar(col = purple6))
# y-axis labels
y_lab <- format(y_pos, big.mark=",", scientific = F)
grid.text(y_lab, x = unit(1, "npc") - unit(6, "mm"), y = unit(y_pos, "native"),
          just = c("right", "center"), gp = gpar(fontsize = 8))



# Another Viewport
popViewport(n = 1)
pushViewport(viewport(layout.pos.row = 6, layout.pos.col = 2))
x_tick_pos <- seq(0,1,length.out = 10)
# Tick marks on y-axis
grid.segments(x0 = unit(x_tick_pos, "native"),y0 =unit(1, "npc")-unit(4, "mm"), 
              x1 = unit(x_tick_pos, "native"),y1 =unit(1, "npc")-unit(2, "mm"),
              gp = gpar(col = purple6))
# x-axis labels
x_lab <- month.abb[4:12]
x_lab_pos <- seq(mean(x_tick_pos[1:2]), mean(x_tick_pos[9:10]), length.out = 9)
grid.text(x_lab, x = unit(x_lab_pos, "native"), 
          y = unit(1, "npc") - unit(3, "mm"),
          just = c("center", "top"), gp = gpar(fontsize = 8))

# Year label
grid.text(2021, x = x_lab_pos[1], 
          y = unit(1, "npc") - unit(6, "mm"),
          just = c("center", "top"), gp = gpar(fontsize = 8, fontface = "bold"))


# Go back to the entire plotting area
popViewport(n=0)
# logo
grid.raster(logo, x = 1, y = 0, width = unit(1, "in"), 
            just = c("right", "bottom"))
