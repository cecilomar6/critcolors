#' @title Color Map Data
#'
#' @description A data set containing the Hex codes for the original CritLab Colors.
#'
#'
#' @author Cecilia López-Martínez: \email{clm@@crit-lab.org} /

critcolors.map <- c("#03034b",
                    "#300b4b",
                    "#530541",
                    "#75032f",
                    "#9c340a",
                    "#d76b02",
                    "#f09a06",
                    "#f4d146")



#' @title CritLab Color Palette
#'
#' @description This function creates a vector of \code{n} equally spaced colors
#'  along the critcolors color map.
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#'
#' @param alpha	The alpha transparency, a number in [0,1], see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in [0,1] at which the color map begins.
#'
#' @param end The (corrected) hue in [0,1] at which the color map ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'  colors are ordered from darkest to lightest. If -1, the order of colors is
#'  reversed.
#'
#' @return \code{critcolors} returns a character vector, \code{cv}, of color hex
#'  codes. This can be used either to create a user-defined color palette for
#'  subsequent graphics by \code{palette(cv)}, a \code{col =} specification in
#'  graphics functions or in \code{par}.
#'
#' @author
#' Cecilia López-Martínez: \email{clm@@crit-lab.org} /
#' Code adapted from the "viridis" package by Simon Garnier: \email{garnier@@njit.edu} / \href{https://twitter.com/sjmgarnier}{@@sjmgarnier}
#'
#' @export
critcolors <- function(n, alpha = 1, begin = 0, end = 1, direction = 1) {

  if (begin < 0 | begin > 1 | end < 0 | end > 1) {
    stop("begin and end must be in [0,1]")
  }

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }

  if (n == 0) {
    return(character(0))
  }

  if (direction == -1) {
    tmp <- begin
    begin <- end
    end <- tmp
  }


  fn_cols <- grDevices::colorRamp(critcolors.map, space = "Lab", interpolate = "spline")
  cols <- fn_cols(seq(begin, end, length.out = n)) / 255
  grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}


#' @title Critcolors Color Palettes
#'
#' @description A wrapper function around critcolors to
#'  turn it into a palette function compatible with
#'  \code{\link[ggplot2]{discrete_scale}}.
#'
#' @param alpha The alpha transparency, a number in [0,1], see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in [0,1] at which the color map begins.
#'
#' @param end The (corrected) hue in [0,1] at which the color map ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'  colors are ordered from darkest to lightest. If -1, the order of colors is
#'  reversed.
#'
#' @author Cecilia López-Martínez: \email{clm@@crit-lab.org} /
#' Code adapted from the "viridis" package by
#' @author Bob Rudis: \email{bob@@rud.is} / \href{https://twitter.com/hrbrmstr}{@@hrbrmstr}
#' @author Simon Garnier: \email{garnier@@njit.edu} / \href{https://twitter.com/sjmgarnier}{@@sjmgarnier}
#'
#'
#' @importFrom critcolors critcolors
#'
#' @export
critcolors_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1) {
  function(n) {
    critcolors(n, alpha, begin, end, direction)
  }
}


#' @title CritColors Color Scales for ggplot2
#'
#' @description Scale functions (fill and colour/color) for
#'  \code{\link[ggplot2]{ggplot2}}.
#'
#' @param ... Parameters to \code{\link[ggplot2]{discrete_scale}} if
#'  \code{discrete == TRUE}, or \code{\link[ggplot2]{scale_fill_gradientn}}/
#'  \code{\link[ggplot2]{scale_color_gradientn}} if \code{discrete == FALSE}.
#'
#' @param alpha The alpha transparency, a number in [0,1], see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in [0,1] at which the color map begins.
#'
#' @param end The (corrected) hue in [0,1] at which the color map ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'  colors are as output by \code{\link[viridis]{viridis_pal}}. If -1, the order
#'  of colors is reversed.
#'
#' @param discrete Generate a discrete palette? (default: \code{FALSE} -
#'  generate continuous palette).
#'
#' @author Cecilia López-Martínez: \email{clm@@crit-lab.org} /
#' Code adapted from the "viridis" package by
#' @author Noam Ross \email{noam.ross@@gmail.com} / \href{https://twitter.com/noamross}{@@noamross}
#' @author Bob Rudis \email{bob@@rud.is} / \href{https://twitter.com/hrbrmstr}{@@hrbrmstr}
#' @author Simon Garnier: \email{garnier@@njit.edu} / \href{https://twitter.com/sjmgarnier}{@@sjmgarnier}
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @importFrom gridExtra grid.arrange
#'
#' @export
scale_fill_critcolors <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
                                  discrete = FALSE) {
  if (discrete) {
    discrete_scale("fill", "critcolors", critcolors_pal(alpha, begin, end, direction), ...)
  } else {
    scale_fill_gradientn(colours = critcolors(256, alpha, begin, end, direction), ...)
  }

}

#' @rdname scale_color_critcolors
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#' @export
scale_color_critcolors <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
                                   discrete = FALSE) {
  if (discrete) {
    discrete_scale("colour", "critcolors", critcolors_pal(alpha, begin, end, direction), ...)
  } else {
    scale_color_gradientn(colours = critcolors(256, alpha, begin, end, direction), ...)
  }
}


#' @rdname scale_color_critcolors
#' @aliases scale_color_critcolors
#' @export
scale_colour_critcolors <- scale_color_critcolors
