/*
 * Bos Taurus Sample # 10
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create user defined filters
 * to do digital image processing.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR hBitmap_Source, hBitmap

PROCEDURE MAIN

   /*
    * Because OOHG executes ON PAINT before executing ON INIT
    * the image must be loaded before the window's activation.
    *
    * All loaded bitmaps must be released to avoid memory leaks.
    */

   PRIVATE hBitmap_Source := BT_BitmapLoadFile( "sami.jpg" )
   PRIVATE hBitmap := BT_BitmapClone( hBitmap_Source )

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 700 ;
      HEIGHT 600 ;
      VIRTUAL WIDTH 1000 ;
      VIRTUAL HEIGHT 1000 ;
      TITLE "Bos Taurus: Digital Image Processing" ;
      MAIN ;
      ON RELEASE BT_BitmapRelease( hBitmap ) ;
      ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. ) ;
      ON PAINT Proc_ON_PAINT() ;
      NODWP

      DEFINE MAIN MENU
         DEFINE POPUP "EFFECTS"
            MENUITEM "Invert"         ACTION Proc_EFFECT( 1 )
            MENUITEM "Grayness"       ACTION Proc_EFFECT( 2 )
            MENUITEM "Brightness"     ACTION Proc_EFFECT( 3 )
            MENUITEM "Contrast"       ACTION Proc_EFFECT( 4 )
            MENUITEM "Modify Color"   ACTION Proc_EFFECT( 5 )
            MENUITEM "Gamma Correct"  ACTION Proc_EFFECT( 6 )
         END POPUP

         DEFINE POPUP "BLUR"
            MENUITEM "VERTICAL"       ACTION Proc_EFFECT( 7, 1 )
            MENUITEM "HORIZONTAL"     ACTION Proc_EFFECT( 7, 2 )
            MENUITEM "ANGLE45"        ACTION Proc_EFFECT( 7, 3 )
            MENUITEM "ANGLE135"       ACTION Proc_EFFECT( 7, 4 )
            MENUITEM "ALLDIRECTIONS"  ACTION Proc_EFFECT( 7, 5 )
         END POPUP

         DEFINE POPUP "SHARPEN"
            MENUITEM "VERTICAL"       ACTION Proc_EFFECT( 8, 1 )
            MENUITEM "HORIZONTAL"     ACTION Proc_EFFECT( 8, 2 )
            MENUITEM "ANGLE45"        ACTION Proc_EFFECT( 8, 3 )
            MENUITEM "ANGLE135"       ACTION Proc_EFFECT( 8, 4 )
            MENUITEM "ALLDIRECTIONS"  ACTION Proc_EFFECT( 8, 5 )
         END POPUP

         DEFINE POPUP "EDGE"
            MENUITEM "ALLDIRECTIONS"  ACTION Proc_EFFECT( 9, 5 )
            MENUITEM "SOBEL Method"   ACTION Proc_EFFECT( 9, 6 )
            MENUITEM "PREWITT Method" ACTION Proc_EFFECT( 9, 7 )
            MENUITEM "KIRSH Method"   ACTION Proc_EFFECT( 9, 8 )
         END POPUP

         DEFINE POPUP "EMBOSS1"
            MENUITEM "EAST"           ACTION Proc_EFFECT( 10, 1 )
            MENUITEM "NORTH"          ACTION Proc_EFFECT( 10, 2 )
            MENUITEM "NORTH_EAST"     ACTION Proc_EFFECT( 10, 3 )
            MENUITEM "NORTH_WEST"     ACTION Proc_EFFECT( 10, 4 )
            MENUITEM "SOUTH"          ACTION Proc_EFFECT( 10, 5 )
            MENUITEM "SOUTH_EAST"     ACTION Proc_EFFECT( 10, 6 )
            MENUITEM "SOUTH_WEST"     ACTION Proc_EFFECT( 10, 7 )
            MENUITEM "WEST"           ACTION Proc_EFFECT( 10, 8 )
         END POPUP

         DEFINE POPUP "EMBOSS2"
            MENUITEM "EAST"           ACTION Proc_EFFECT( 11, 1 )
            MENUITEM "NORTH"          ACTION Proc_EFFECT( 11, 2 )
            MENUITEM "NORTH_EAST"     ACTION Proc_EFFECT( 11, 3 )
            MENUITEM "NORTH_WEST"     ACTION Proc_EFFECT( 11, 4 )
            MENUITEM "SOUTH"          ACTION Proc_EFFECT( 11, 5 )
            MENUITEM "SOUTH_EAST"     ACTION Proc_EFFECT( 11, 6 )
            MENUITEM "SOUTH_WEST"     ACTION Proc_EFFECT( 11, 7 )
            MENUITEM "WEST"           ACTION Proc_EFFECT( 11, 8 )
         END POPUP
      END MENU

      @ 450, 280 BUTTON Button_1 ;
         CAPTION "Restore Image" ;
         ACTION Proc_EFFECT( 0 )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   MAXIMIZE WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE Proc_ON_PAINT
   LOCAL Col := - Win1.HscrollBar.value
   LOCAL Row := - Win1.VscrollBar.value
   LOCAL hDC, BTstruct

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
   BT_DrawGradientFillVertical( hDC, 0, 0, BT_ClientAreaWidth( "Win1" ), BT_ClientAreaHeighT( "Win1" ), { 100, 0, 33 }, BLACK )
   BT_DrawBitmap( hDC, Row + 10, Col + 10, BT_BitmapWidth( hBitmap ), BT_BitmapHeight( hBitmap ), BT_COPY, hBitmap )
   BT_DeleteDC( BTstruct )
RETURN


PROCEDURE Proc_EFFECT( nEffect, nIndex )
   BT_BitmapRelease( hBitmap )
   hBitmap := BT_BitmapClone( hBitmap_Source )

   DO CASE
   CASE nEffect == 1 
      BT_BitmapInvert( hBitmap )
   CASE nEffect == 2
      BT_BitmapGrayness( hBitmap, 100 )
   CASE nEffect == 3
      BT_BitmapBrightness( hBitmap, 70 )
   CASE nEffect == 4
      BT_BitmapContrast( hBitmap, 65 )
   CASE nEffect == 5
      BT_BitmapModifyColor( hBitmap, -15, 20, 30 )
   CASE nEffect == 6
      BT_BitmapGammaCorrect( hBitmap, 0.2, 0.8, 1.4 )
   CASE nEffect == 7
      BT_BitmapConvolutionFilter3x3( hBitmap, BT_aFILTER_BLUR( nIndex, 5, 1, 0, 0 ) )
   CASE nEffect == 8
      BT_BitmapConvolutionFilter3x3( hBitmap, BT_aFILTER_SHARPEN( nIndex, 1, 3, 0, 0 ) )
   CASE nEffect == 9
      IF nIndex == 5
         BT_BitmapConvolutionFilter3x3( hBitmap, BT_aFILTER_EDGE( nIndex, 1, 8, 0, 0 ) )
      ELSEIF nIndex == 6
         // SOBEL Method Edge Detection (apply two filters consecutive )
         BT_BitmapConvolutionFilter3x3( hBitmap, { 1, 0, -1, 2, 0, -2, 1, 0, -1, 0, 0 } )
         BT_BitmapConvolutionFilter3x3( hBitmap, { 1, 2, 1, 0, 0, 0, -1, -2, -1, 0, 0 } )
      ELSEIF nIndex == 7
         // PREWITT Method Edge Detection (apply two filters consecutive )
         BT_BitmapConvolutionFilter3x3( hBitmap, { 1, 0, -1, 1, 0, -1, 1, 0, -1, 0, 0 } )
         BT_BitmapConvolutionFilter3x3( hBitmap, { 1, 1, 1, 0, 0, 0, -1, -1, -1, 0, 0 } )
      ELSEIF nIndex == 8
         // KIRSH Method Edge Detection (apply two filters consecutive )
         BT_BitmapConvolutionFilter3x3( hBitmap, { 5, -3, -3, 5, 0, -3, 5, -3, -3, 0, 0 } )
         BT_BitmapConvolutionFilter3x3( hBitmap, { 5, 5, 5, -3, 0, -3, -3, -3, -3, 0, 0 } )
      ENDIF
   CASE nEffect == 10
      BT_BitmapConvolutionFilter3x3( hBitmap, BT_aFILTER_EMBOSS( nIndex, 1, 0, 0, 128 ) )
   CASE nEffect == 11
      BT_BitmapConvolutionFilter3x3( hBitmap, BT_aFILTER_EMBOSS( nIndex, 3, 1, 0, 0 ) )
   ENDCASE

   BT_ClientAreaInvalidateAll( "Win1" )
RETURN


/*
 *
 * RULES OF THUMB TO CREATE USER DEFINED CONVOLUTION FILTERS
 *
 * BT_aFILTER := { k1, k2, k3, ;
 *                 k4, k5, k6, ;
 *                 k7, k8, k9, ;
 *                 divisor, bias}
 *
 *         Center Cell Value    Surrounding Cell Values
 *         (k5)                 (k1, k2, k3, k4, k6, k7, k8, k9)
 *         -----------------    --------------------------------------
 * Blur     POSITIVE             Symmetrical pattern of POSITIVE values
 * Sharpen  POSITIVE             Symmetrical pattern of NEGATIVE values
 * Edges    NEGATIVE             Symmetrical pattern of POSITIVE values
 * Emboss   POSITIVE             Symmetrical pattern of NEGATIVE values on one side and POSITIVE values on the other
 *
 * sum = (Center Cell Value) + (Surrounding Cell Values) = k1 + k2 + k3 + k4 + k5 + k6 + k7 + k8 + k9
 *
 * if sum / divisor = 1  ---> Retain the brightness of the original image.
 * if sum / divisor > 1  ---> Increases the bright of the image
 * if sum / divisor < 1  ---> Darken the image
 *
 * Bias increments (positive value) or decrements (negative value) the end color of the currently processed pixel
 *
 * To reduce the effect of a filter (Blur, Sharpen, Edges, etc.) you must increase the value of the center cell (k5)
 *
 */


FUNCTION BT_aFILTER_BLUR( index, value, weight, add, bias )
   LOCAL aFILTER, v

   v := value
   DEFAULT v      := 1
   DEFAULT weight := 1
   DEFAULT add    := 0
   DEFAULT bias   := 0

   /* For a Blur filter, use a positive center value and surround
    * it with a symmetrical pattern of other positive values.
    */

   aFILTER := ;
      { { 0, v, 0, 0, weight, 0, 0,  v, 0, weight + add + v * 2, bias}, ; // VERTICAL
        { 0, 0, 0, v, weight, v, 0,  0, 0, weight + add + v * 2, bias}, ; // HORIZONTAL
        { 0, 0, v, 0, weight, 0, v,  0, 0, weight + add + v * 2, bias}, ; // ANGLE45
        { v, 0, 0, 0, weight, 0, 0,  0, v, weight + add + v * 2, bias}, ; // ANGLE135
        { v, v, v, v, weight, v, v,  v, v, weight + add + v * 8, bias} }  // ALLDIRECTIONS
Return aFILTER[ index ]


FUNCTION BT_aFILTER_SHARPEN( index, value, weight, add, bias )
   LOCAL aFILTER, v

   v := value
   DEFAULT v      := 1
   DEFAULT weight := 1
   DEFAULT add    := 0
   DEFAULT bias   := 0

   /* For a Sharpen filter, use a positive center value and surround
    * it with a symmetrical pattern of negative values.
    */

   aFILTER := ;
      { {  0, -v,  0,  0, weight,  0,  0, -v,  0, weight + add - v * 2, bias}, ; // VERTICAL
        {  0,  0,  0, -v, weight, -v,  0,  0,  0, weight + add - v * 2, bias}, ; // HORIZONTAL
        {  0,  0, -v,  0, weight,  0, -v,  0,  0, weight + add - v * 2, bias}, ; // ANGLE45
        { -v,  0,  0,  0, weight,  0,  0,  0, -v, weight + add - v * 2, bias}, ; // ANGLE135
        { -v, -v, -v, -v, weight, -v, -v, -v, -v, weight + add - v * 8, bias} }  // ALLDIRECTIONS
Return aFILTER[ index ]


FUNCTION BT_aFILTER_EDGE( index, value, weight, add, bias )
   LOCAL aFILTER, v

   v := value
   DEFAULT v      := 1
   DEFAULT weight := 1
   DEFAULT add    := 0
   DEFAULT bias   := 0

   /* For an edge filter, use a negative center value and surround
    * it with a symmetrical pattern of positive values.
    */

   aFILTER := ;
      { { 0, v, 0, 0, -weight, 0, 0, v, 0, -weight + add + v * 2, bias}, ; // VERTICAL
        { 0, 0, 0, v, -weight, v, 0, 0, 0, -weight + add + v * 2, bias}, ; // HORIZONTAL
        { 0, 0, v, 0, -weight, 0, v, 0, 0, -weight + add + v * 2, bias}, ; // ANGLE45
        { v, 0, 0, 0, -weight, 0, 0, 0, v, -weight + add + v * 2, bias}, ; // ANGLE135
        { v, v, v, v, -weight, v, v, v, v, -weight + add + v * 8, bias} }  // ALLDIRECTIONS
Return aFILTER[ index ]


FUNCTION BT_aFILTER_EMBOSS( index, value, weight, add, bias )
   LOCAL aFILTER, v

                 // Gray   Color
   v := value
   DEFAULT v      := 1     // 3
   DEFAULT weight := 0     // 1
   DEFAULT add    := 0     // 0
   DEFAULT bias   := 128   // 0

   /* For an Embossing filter, use a positive center value and surround
    * it in a symmetrical pattern of negative values on one side and
    * positive values on the other.
    */

   aFILTER := ;
      { { -v,  0,  v, -v, weight,  v, -v,  0,  v, weight + add, bias }, ; // Right          EAST
        {  v,  v,  v,  0, weight,  0, -v, -v, -v, weight + add, bias }, ; // Top            NORTH
        {  0,  v,  v, -v, weight,  v, -v, -v,  0, weight + add, bias }, ; // Top_Right      NORTH_EAST
        {  v,  v,  0,  v, weight, -v,  0, -v, -v, weight + add, bias }, ; // Top_Left       NORTH_WEST
        { -v, -v, -v,  0, weight,  0,  v,  v,  v, weight + add, bias }, ; // Bottom         SOUTH
        { -v, -v,  0, -v, weight,  v,  0,  v,  v, weight + add, bias }, ; // Bottom_Right   SOUTH_EAST
        {  0, -v, -v,  v, weight, -v,  v,  v,  0, weight + add, bias }, ; // Bottom_Left    SOUTH_WEST
        {  v,  0, -v,  v, weight, -v,  v,  0, -v, weight + add, bias } }  // Left           WEST
Return aFILTER[ index ]


/*
 * aFILTER :=                                        { k1, k2, k3, k4,       k5, k6, k7, k8, k9,     Divisor, Bias }
 */
/*
#define BT_Kernel3x3Filter_Blur( nWeight )           {  0,  2,  0,  2,  nWeight,  2,  0,  2,  0, nWeight  +8,   0 } // Blur (Borrado)
#define BT_Kernel3x3Filter_GaussianBlur( nWeight )   {  1,  2,  1,  2,  nWeight,  2,  1,  2,  1, nWeight +12,   0 } // Gaussian Blur (Borrado Gaussiano)
#define BT_Kernel3x3Filter_Sharpen( nWeight )        {  0, -1,  0, -1,  nWeight, -1,  0, -1,  0, nWeight  -4,   0 } // Sharpen (Nitidez)
#define BT_Kernel3x3Filter_Smooth( nWeight )         {  1,  1,  1,  1,  nWeight,  1,  1,  1,  1, nWeight  +8,   0 } // Smooth (Suavizado)
#define BT_Kernel3x3Filter_GaussianSmooth( nWeight ) {  0,  1,  0,  1,  nWeight,  1,  0,  1,  0, nWeight  +4,   0 } // Gaussian Smooth (Suavizado Gaussiano)
#define BT_Kernel3x3Filter_MeanRemoval( nWeight )    { -1, -1, -1, -1,  nWeight, -1, -1, -1, -1, nWeight  -8,   0 } // Mean Removal
#define BT_Kernel3x3Filter_EdgeDetection1            {  1,  1,  1,  1,       -8,  1,  1,  1,  1,           0,   0 } // Detects Edges in All Directions
#define BT_Kernel3x3Filter_EdgeDetection2            {  1,  1,  1,  1,       -7,  1,  1,  1,  1,           1,   0 } // Detects Edges Execessively

#define BT_Kernel3x3Filter_0                         {  0,  0,  0,  0,        1,  0,  0,  0,  0,           1,   0 } // Identity Filter, returning the original image
#define BT_Kernel3x3Filter_1                         {  1,  1,  1,  1,        1,  1,  1,  1,  1,           9,   0 } // Smooth // Blur // Mean
#define BT_Kernel3x3Filter_2                         {  0,  1,  0,  1,        4,  1,  0,  1,  0,           8,   0 } // Gaussian Smooth
#define BT_Kernel3x3Filter_3                         {  0, -1,  0, -1,        9, -1,  0, -1,  0,           5,   0 } // Sharpen
#define BT_Kernel3x3Filter_4                         {  1,  2,  1,  2,        4,  2,  1,  2,  1,          16,   0 } // Gaussian Blur
#define BT_Kernel3x3Filter_5                         {  0, -2,  0, -2,       11, -2,  0, -2,  0,           3,   0 } // Sharpen2
#define BT_Kernel3x3Filter_6                         { -1, -1, -1, -1,        9, -1, -1, -1, -1,           1,   0 } // Mean Removal (Sharpen)
#define BT_Kernel3x3Filter_7                         {  1,  1,  1,  1,       -8,  1,  1,  1,  1,           1,   0 } // Detects Edges in all directions
#define BT_Kernel3x3Filter_8                         {  0,  2,  0,  2,        2,  2,  0,  2,  0,          10,   0 } // Blur
#define BT_Kernel3x3Filter_9                         {  1,  1,  1,  1,       -7,  1,  1,  1,  1,           1,   0 } // Edge Execessively
#define BT_Kernel3x3Filter_10                        { -1, -1, -1, -1,        8, -1, -1, -1, -1,           0, 128 } // Emboss All Directions
#define BT_Kernel3x3Filter_11                        { -1,  0, -1,  0,        4,  0, -1,  0, -1,           0, 128 } // Emboss Laplacian
#define BT_Kernel3x3Filter_12                        {  0, -1,  0, -1,        4, -1,  0, -1,  0,           0, 128 } // Emboss Horizontal-Vertical
#define BT_Kernel3x3Filter_13                        {  0,  0,  0, -1,        2, -1,  0,  0,  0,           0, 128 } // Emboss Horizontal Only
#define BT_Kernel3x3Filter_14                        {  0, -1,  0,  0,        0,  0,  0,  1,  0,           0, 128 } // Emboss Vertical Only (90º)
#define BT_Kernel3x3Filter_15                        {  1,  1,  1,  0,        0,  0, -1, -1, -1,           0, 128 } // Emboss Edge Detect
#define BT_Kernel3x3Filter_16                        {  1,  0,  0,  0,        0,  0,  0,  0, -1,           0, 128 } // Emboss 135°
#define BT_Kernel3x3Filter_17                        { -1, -1,  0, -1,        0,  1,  0,  1,  1,           0, 128 } // Emboss 45°
#define BT_Kernel3x3Filter_18                        {  0,  0,  0,  0,        1,  0,  0,  0, -1,           0, 128 } // Emboss
#define BT_Kernel3x3Filter_19                        {  2,  0,  0,  0,       -1,  0,  0,  0, -1,           0, 128 } // Emboss
#define BT_Kernel3x3Filter_20                        { -2, -1,  0, -1,        1,  1,  0,  1,  2,           1,   0 } // Emboss Color

// EMBOSS Gray
#define BT_Kernel3x3Filter_21                        { -1,  0,  1, -1,        0,  1, -1,  0,  1,           0, 128 } // EAST
#define BT_Kernel3x3Filter_22                        {  1,  1,  1,  0,        0,  0, -1, -1, -1,           0, 128 } // NORTH
#define BT_Kernel3x3Filter_23                        {  0,  1,  1, -1,        0,  1, -1, -1,  0,           0, 128 } // NORTH_EAST
#define BT_Kernel3x3Filter_24                        {  1,  1,  0,  1,        0, -1,  0, -1, -1,           0, 128 } // NORTH_WEST
#define BT_Kernel3x3Filter_25                        { -1, -1, -1,  0,        0,  0,  1,  1,  1,           0, 128 } // SOUTH
#define BT_Kernel3x3Filter_26                        { -1, -1,  0, -1,        0,  1,  0,  1,  1,           0, 128 } // SOUTH_EAST
#define BT_Kernel3x3Filter_27                        {  0, -1, -1,  1,        0, -1,  1,  1,  0,           0, 128 } // SOUTH_WEST
#define BT_Kernel3x3Filter_28                        {  1,  0, -1,  1,        0, -1,  1,  0, -1,           0, 128 } // WEST
 
// BLUR
#define BT_Kernel3x3Filter_29                        {  0,  1,  0,  0,        1,  0,  0,  1,  0,           3,   0 } // VERTICAL
#define BT_Kernel3x3Filter_30                        {  0,  0,  0,  1,        1,  1,  0,  0,  0,           3,   0 } // HORIZONTAL
#define BT_Kernel3x3Filter_31                        {  0,  0,  1,  0,        1,  0,  1,  0,  0,           3,   0 } // ANGLE45
#define BT_Kernel3x3Filter_32                        {  1,  0,  0,  0,        1,  0,  0,  0,  1,           3,   0 } // ANGLE135
#define BT_Kernel3x3Filter_33                        {  1,  1,  1,  1,        1,  1,  1,  1,  1,           9,   0 } // ALLDIRECTIONS

// EMBOSS Color
#define BT_Kernel3x3Filter_34                        { -5,  0,  0,  0,        1,  0,  0,  0,  5,           1,   0 } // Emboss Color
#define BT_Kernel3x3Filter_35                        { -2,  0,  2, -2,        1,  2, -2,  0,  2,           1,   0 } // EAST
#define BT_Kernel3x3Filter_36                        {  2,  2,  2,  0,        1,  0, -2, -2, -2,           1,   0 } // NORTH
#define BT_Kernel3x3Filter_37                        {  0,  2,  2, -2,        1,  2, -2, -2,  0,           1,   0 } // NORTH_EAST
#define BT_Kernel3x3Filter_38                        {  2,  2,  0,  2,        1, -2,  0, -2, -2,           1,   0 } // NORTH_WEST
#define BT_Kernel3x3Filter_39                        { -2, -2, -2,  0,        1,  0,  2,  2,  2,           1,   0 } // SOUTH
#define BT_Kernel3x3Filter_40                        { -2, -2,  0, -2,        1,  2,  0,  2,  2,           1,   0 } // SOUTH_EAST
#define BT_Kernel3x3Filter_41                        {  0, -2, -2,  2,        1, -2,  2,  2,  0,           1,   0 } // SOUTH_WEST
#define BT_Kernel3x3Filter_42                        {  2,  0, -2,  2,        1, -2,  2,  0, -2,           1,   0 } // WEST
*/


/*
 * EOF
 */
