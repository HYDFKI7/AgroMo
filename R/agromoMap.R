#' agroMoMapUI
#'
#' Bla
#' @param id id
#' @importFrom shiny NS tags checkboxInput selectInput textInput actionButton radioButtons plotOutput updateSelectInput observe imageOutput
#' @importFrom shinyjs toggleState

agroMoMapUI <- function(id){
  
  paletteAlias <- data.frame(src=c(
    "www/img/palette_samples/Greens.png",
    "www/img/palette_samples/Greys.png",
    "www/img/palette_samples/Reds.png",
    "www/img/palette_samples/Yellow-Green-Blue.png",
    "www/img/palette_samples/Yellow-Orange-Brown.png",
    "www/img/palette_samples/Blues.png",
    "www/img/palette_samples/Red-Blue.png",
    "www/img/palette_samples/Red-Yellow-Blue.png",
    "www/img/palette_samples/Red-Yellow-Green.png",
    "www/img/palette_samples/Spectral.png",
    "www/img/palette_samples/Yellow-Green.png"
  ),
  alias=c(
    "Greens", "Greys", "Reds", "Yellow-Green-Blue", 
    "Yellow-Orange-Brown", "Blues",  "Red-Blue", "Red-Yellow-Blue", 
    "Red-Yellow-Green", "Spectral", "Yellow-Green"
  ))
  
  paletteAliasMask <- data.frame(src=c(
    "www/img/palette_samples/LightGre_mask.png",
    "www/img/palette_samples/DarkGre_mask.png",
    "www/img/palette_samples/White_mask.png"
  ),
  alias=c(
    "Light Grey", "Dark Grey", "White"
  ))
  
  
  ns <- NS(id)
  tags$div(id = ns(id),
           
           tags$div(
             id = paste0(ns("invert"),"_container"),
             checkboxInput(ns("invert"), label = " inverted", value = FALSE)
           ),
           tags$img(id = ns("greysc"),src="www/img/palette_samples/LightGre_mask.png", draggable = FALSE),
           tags$img(id = ns("greensc"),src="www/img/palette_samples/Greens.png", draggable = FALSE),
           tags$div(
             id = paste0(ns("countrycont"),"_container"),
             checkboxInput(ns("countrycont"), label = "country contour", value = TRUE)
           ),
           tags$div(
             id = paste0(ns("latlon"),"_container"),
             checkboxInput(ns("latlon"), label = "lat/lon lines", value = TRUE)
           ),
           tags$div(
             id = paste0(ns("datasource"),"_container"),title="Select sql file to present query results on a map",
             selectInput(ns("datasource"),"data source:","")
           ),
           tags$div(
             id = paste0(ns("palette"),"_container"),title="Select colour palette for map",
             selectInput(ns("palette"),"palette:",choices= paletteAlias[,2])),
           tags$div(
             id = paste0(ns("radio"), "_container"), 
             radioButtons(ns("radio"), "", choices= c("  " = "colnumb", " " = "inteval"), selected = "colnumb", inline = TRUE)
           ),
           tags$div(
             id = paste0(ns("colnumb"),"_container"),title="Select the number of colours/subranges to be distinguished on the map",
             selectInput(ns("colnumb"),"colors:", choices=2:32)
           ),
           tags$div(
             id = paste0(ns("minprec"),"_container"),title="Select the number of decimal places shown in the presented values",
             selectInput(ns("minprec"),"decimal places:",choices=c(0,1,2,3,4,5))
           ),
           tags$div(
             id = paste0(ns("min"),"_container"), title="Set the minimum value for the data presented on the map",
             # textInput(ns("min"),"min-max value:",as.numeric(NA), value=floor(min(data))) # with not empty field
             textInput(ns("min"),"min-max value:",as.numeric(NA)) # with empty field
           ),
           tags$div(
             id = paste0(ns("max"),"_container"),title="Set the maximum value for the data presented on the map",
             # textInput(ns("max"),"-",as.numeric(NA), value=ceiling(max(data))) # with not empty field
             textInput(ns("max"),"-",as.numeric(NA)) # with empty field
           ),
           tags$div(
             id = paste0(ns("bw"),"_container"),title="Set the bin width between the minium and maximum values",
             # textInput(ns("bw"),"interval:",as.numeric(NA), value=floor((floor(max(data))-floor(min(data)))/8)) # with not empty field
             textInput(ns("bw"),"interval:",as.numeric(NA)) # with empty field
           ),
           
           #    tags$div(
           #      id = paste0(ns("maxprec"),"_container"),
           #      selectInput(ns("maxprec"),"precision of rounding:",choices=c(0,1,2,3,4,5))
           #    ),
           tags$div(
             id = paste0(ns("maskcol"),"_container"),title="Select mask colour (for regions with no data)",
             selectInput(ns("maskcol"),"mask color:", choices=paletteAliasMask[,2])
           ),
           
           tags$div(
             id = paste0(ns("maptitle"),"_container"), title="Add title to the map",
             textInput(ns("maptitle"), "map title:")
           ),
           tags$div(
             id = paste0(ns("metadata"),"_container"),
             textInput(ns("metadata"), "metadata:")
           ),
           #tags$div(id="maskpreview","mask preview:"),
           #tags$div(id="palettepreview","palette preview:"),
           
           #itt a funkcionalitas kerdeses    
           tags$div(id = ns("Buttons"),
                    actionButton(ns("create"),label = "CREATE MAP")),
           #actionButton(ns("save"),label="SAVE to FILE")),
           tags$script(HTML("
                            let palette = {
                            \"src\":[\"www/img/palette_samples/Greens.png\",
                            \"www/img/palette_samples/Greys.png\",
                            \"www/img/palette_samples/Reds.png\",
                            \"www/img/palette_samples/YlGnBu.png\",
                            \"www/img/palette_samples/YlOrBr.png\",
                            \"www/img/palette_samples/Blues.png\",
                            \"www/img/palette_samples/RdBu.png\",
                            \"www/img/palette_samples/RdYlBu.png\",
                            \"www/img/palette_samples/RdYlGr.png\",
                            \"www/img/palette_samples/Spectral.png\",
                            \"www/img/palette_samples/YlGn.png\",
                            \"www/img/palette_samples/Greens_reverse.png\",
                            \"www/img/palette_samples/Greys_reverse.png\",
                            \"www/img/palette_samples/Reds_reverse.png\",
                            \"www/img/palette_samples/YlGnBu_reverse.png\",
                            \"www/img/palette_samples/YlOrBr_reverse.png\",
                            \"www/img/palette_samples/Blues_reverse.png\",
                            \"www/img/palette_samples/RdBu_reverse.png\",
                            \"www/img/palette_samples/RdYlBu_reverse.png\",
                            \"www/img/palette_samples/RdYlGr_reverse.png\",
                            \"www/img/palette_samples/Spectral_reverse.png\",
                            \"www/img/palette_samples/YlGn_reverse.png\"
                            ],
                            \"colorscheme\" : [      \"Greens\", \"Greys\", \"Reds\", \"Yellow-Green-Blue\", 
                            \"Yellow-Orange-Brown\", \"Blues\",  \"Red-Blue\", \"Red-Yellow-Blue\", 
                            \"Red-Yellow-Green\", \"Spectral\", \"Yellow-Green\",
                            \"Greens_inverse\", \"Greys_inverse\", \"Reds_inverse\", \"Yellow-Green-Blue_inverse\", 
                            \"Yellow-Orange-Brown_inverse\", \"Blues_inverse\",  \"Red-Blue_inverse\", \"Red-Yellow-Blue_inverse\", 
                            \"Red-Yellow-Green_inverse\", \"Spectral_inverse\", \"Yellow-Green_inverse\"
                            ]
                            
                            }
                            
                            Shiny.addCustomMessageHandler ('palletteChanger', function(message) {
                            $(\"#mapdiv-greensc\").attr(\"src\", palette.src[palette.colorscheme.indexOf(message)])
                            }
                            
                            )         
                            
                            
                            
                            
                            
                            
                            ")),
           
           tags$script(HTML("
                            let paletteMask = {
                            \"src\":[\"www/img/palette_samples/LightGre_mask.png\",
                            \"www/img/palette_samples/DarkGre_mask.png\",
                            \"www/img/palette_samples/White_mask.png\"
                            ],
                            \"colorscheme\" : [      \"Light Grey\", \"Dark Grey\", \"White\"
                            ]
                            
                            }
                            
                            Shiny.addCustomMessageHandler ('palletteChangerMask', function(message) {
                            $(\"#mapdiv-greysc\").attr(\"src\", paletteMask.src[paletteMask.colorscheme.indexOf(message)])
                            }
                            )         
                            
                            ")),
           imageOutput(ns("map_left"), width="358px",height="230px"),
           imageOutput(ns("map_right"),width="358px",height="230px"),
           tags$script(HTML("$('#mapdiv-map_left').on('click','img',function(){
                            $(this).toggleClass('tozoom')
                            })")),
    tags$script(HTML("$('#mapdiv-map_right').on('click','img',function(){
                     $(this).toggleClass('tozoom')
    })"))

    
    
    
           )
                            }

#' agroMoMap 
#' 
#' asdfasfd
#' @param input input
#' @importFrom shiny reactiveValues observe updateSelectInput observe renderPlot renderImage 
#' @importFrom DBI dbConnect


agroMoMap <- function(input, output, session, baseDir, initialList){

    getHexa <- function(name){
        paletteAlias <- data.frame(
                             name=c("Light Grey", "Dark Grey", "White"),
                             hexa=c("#D3D3D3","#A9A9A9","#FFFFFF"),stringsAsFactor=FALSE)
        as.character(paletteAlias[paletteAlias$name==name,"hexa"])
    }

  datas <- reactiveValues(numPlots = 1,oldImage="",connection=NULL,agromoDB = NULL, soilDB = NULL, colnumbSelected = FALSE)
  myColors <- data.frame(
    codes=c("Greens","Greys","Reds","YlGnBu","YlOrBr","Blues","RdBu","RdYlBu","RdYlGn","Spectral","YlGn"), 
    alias=c(
      "Greens", "Greys", "Reds", "Yellow-Green-Blue", 
      "Yellow-Orange-Brown", "Blues",  "Red-Blue", "Red-Yellow-Blue", 
      "Red-Yellow-Green", "Spectral", "Yellow-Green"
    ), stringsAsFactors=FALSE
  )

  ns <- session$ns

  observe({
              if(input$radio=="colnumb"){
                  datas$colnumbSelected <- TRUE
              } else {
                  datas$colnumbSelected <- FALSE
              }
  }) 

  observe({
    initialList()
    dir.create(sprintf("%s/output/query", baseDir()), showWarnings = FALSE)
    dir.create(sprintf("%s/output/map_data", baseDir()), showWarnings = FALSE)
    dir.create(sprintf("%s/output/map_image", baseDir()), showWarnings = FALSE)
    updateSelectInput(session, "datasource", 
                      choices = list.files(sprintf("%s/output/query/",baseDir())),
                      selected = head(list.files(sprintf("%s/output/query/",baseDir())),n=1)
    )
    # print(list.files(sprintf("%s/output/queries/",baseDir())))
    
    if(file.exists(sprintf("%s/output/DB/grid/grid.sqlite3",baseDir()))){
      datas$agromoDB<- sprintf("%s/output/DB/grid/grid.sqlite3",baseDir())
      datas$connection <- dbConnect(RSQLite::SQLite(), datas$agromoDB)
    } else {
      datas$agromoDB <- "~/AgroMoDB/HU-10km.db"
      if(file.exists(datas$agromoDB)){
        datas$connection <- dbConnect(RSQLite::SQLite(), datas$agromoDB)
      }
    }
    
    if(file.exists(sprintf("%s/output/DB/SOIL.db",baseDir()))){
      datas$soilDB <- sprintf("%s/output/DB/SOIL.db",baseDir())
      if(!is.null(datas$connection)){
        dbExecute(datas$connection,sprintf("ATTACH DATABASE '%s' AS soil", normalizePath(datas$soilDB)))
      }
    } else {
      datas$soilDB <- "~/AgroMoDB/SOIL.db"
      if(file.exists(datas$soilDB)) {
        if(!is.null(datas$connection)){
          # browser()
          dbSendQuery(datas$connection,sprintf("ATTACH DATABASE '%s' AS soil", normalizePath(datas$soilDB)))
        }
      }
    }
    
  })
  
  observe({
    if(input$invert==TRUE){# funny
      paletteList <- paste0(input$palette,"_inverse")
    } else {
      paletteList <- input$palette
    }
    session$sendCustomMessage(type="palletteChanger",paletteList)
  })

  observe({
      session$sendCustomMessage(type="palletteChangerMask",input$maskcol)
  })

  oldImage <- ""
  observeEvent(input$create,{
    palette <- myColors$codes[myColors$alias==input$palette]
    # browser()
    
    if(length(input$datasource)>0) {
      sqlName <- sprintf("%s/output/query/%s",baseDir(),input$datasource)
      sqlString <- readChar(sqlName,file.info(sqlName)["size"])
    }
    
    mapData <- basename(tools::file_path_sans_ext(sqlName))
    mapData <- sprintf("%s/output/map_data/%s.csv",baseDir(),mapData)
    mapImage <- basename(tools::file_path_sans_ext(sqlName))
    mapImage <- sprintf("%s/output/map_image/%s.png",baseDir(),mapImage)
    
    if(!is.null(datas$connection) ||
       file.exists(mapData)){
      if(file.exists(mapData)){
          myData_part <- read.csv(mapData)
          myData <- data.frame(plotid=1:1104,error=rep(0,1104),value=rep(NA,1104))
          myData[match(myData_part$plotid,myData$plotid),] <- myData_part
          myData[,1] <- as.numeric(myData[,1])
          myData <- myData[order(myData[,1]),]
        isFailed <- agroMap(myData=myData, nticks=as.numeric(input$colnumb),
                reverseColorScale=input$invert, colorSet=myColors[myColors[,2]==input$palette,1],
                lonlat=input$latlon, imageTitle=mapImage, plotTitle=input$maptitle, countrycont=input$countrycont,
                roundPrecision=as.numeric(input$minprec), minimum=as.numeric(input$min),
                maximum=as.numeric(input$max), binwidth=as.numeric(input$bw),categorical = datas$colnumbSelected,
                maskCol=getHexa(input$maskcol)
        ) 
      } else {
        isFailed <- agroMap(datas$connection, query=sqlString, nticks=as.numeric(input$colnumb),
                reverseColorScale=input$invert,colorSet=myColors[myColors[,2]==input$palette,1], 
                lonlat=input$latlon, imageTitle=mapImage, plotTitle=input$maptitle, countrycont=input$countrycont,
                roundPrecision=as.numeric(input$minprec), outFile=mapData, minimum=as.numeric(input$min),
                maximum=as.numeric(input$max), binwidth=as.numeric(input$bw), categorical = datas$colnumbSelected,
                maskCol=getHexa(input$maskcol)
        )
      }
      

    if(isFailed == 0){

      output$map_left <- renderImage({
        list(src=mapImage)
      },deleteFile=FALSE)
      if(isolate(datas$oldImage)!=""){
        print(isolate(datas$oldImage))
        output$map_right <-  renderImage({
          sourceList <- list(src=isolate(datas$oldImage))
          datas$oldImage <- mapImage
          return(sourceList)
        },deleteFile=FALSE)
      } else {
        datas$oldImage <- mapImage  
      }

    }
      


    }
    
  }) 
  
}
