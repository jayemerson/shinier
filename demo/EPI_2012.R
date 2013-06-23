#
# Build a Shiny data explorer for the 2012 Environmental Performance
# Index data (see http://epi.yale.edu for more information).
#
# Note: this demonstration, if completed, will have side-effects,
# leaving a directory EPI_2012 in your active directory.
# You will have to delete in manually if you don't want it, but you
# might want to examine ui.R and server.R to learn more about Shiny.
#

data(epi)

shinySkeleton("EPI_2012")

##################################################################
# Creating the headerPanel():

headerPanelAdd("2012 Environmental Performance Index", "2012 EPI")
showUI()

##################################################################
# Creating the application in folder EPI_2012, which will
# include ui.R, server.R, and (in this case) a single data object,
# which I creatively call x.Rda.

createApp("EPI_2012")
dir()
dir("EPI_2012")

##################################################################
########### LAUNCHING THE APPLICATION IN YOUR BROWSER ############

########### When done, press <control>-C in the R console ########

runApp("EPI_2012")

