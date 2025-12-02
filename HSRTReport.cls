% =======================================================================================
% Original Author: Martin Oswald (Zürich University of Applied Sciences)
% Modified by: Frederik Beimgraben (University of Applied Sciences Reutlingen)
% Description: This class is a modified version of the ZHAWReport class by Martin Oswald.
% It is used for reports at the University of Applied Sciences Reutlingen.
% =======================================================================================
% License: Creative Commons CC BY 4.0
% Creative Commons Attribution-ShareAlike 4.0 International License.
%
% You should have received a copy of the license along with this
% work. If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
% =======================================================================================

% String comparison Command
\ExplSyntaxOn
\cs_new_eq:NN \strcompare \str_if_eq:eeTF
\ExplSyntaxOff

% Tectonic/XeTeX compatibility - comment out check for broader compatibility
%\ifx\XeTeXversion\undefined
%	\PackageError{HSRTReport}{This class can only be used with XeLaTeX.}{}
%	\stop
%\fi

% Define fallback font commands if they don't exist
\providecommand{\blenderfont}{\sffamily}
\providecommand{\dinfont}{\rmfamily}

%----------------------------------------
%   PATHS
%----------------------------------------
\def\classPath{HSRTReport}
\def\fontsPath{\classPath/Assets/Fonts}
\def\imagesPath{\classPath/Assets/Images}

% Variants option
\RequirePackage{l3keys2e}
\RequirePackage{expl3}
\ExplSyntaxOn
\keys_define:nn { ReportOptions }
  {
    variant .choice:,
    variant / meti   .code:n = { \def\ReportVariant{meti} },
    variant / mki    .code:n = { \def\ReportVariant{mki} },
    variant / huc    .code:n = { \def\ReportVariant{huc} },
    variant .initial: n = {meti} % METI as default option
  }
\ProcessKeysOptions { ReportOptions }
\ExplSyntaxOff
\providecommand{\ReportVariant}{meti}

%----------------------------------------
%   CLASS DEFINITION AND PARAMETERS
%----------------------------------------
% Original: ZHAWReport.cls by Martin Oswald
\def\true{true}
\def\false{false}

\NeedsTeXFormat{LaTeX2e}
\newcommand{\classname}{HSRTReport/HSRTReport}
\ProvidesClass{\classname}[HSRT Report Class]
\providecommand{\baseclass}{scrbook}

% Option setting if to show footer logos
\def\ShowFooterLogos{\false}
\DeclareOption{footerlogos}{
  \def\ShowFooterLogos{\true}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptions\relax

% Pass 2cm border on each side to class

% Load the base class with options
\LoadClass{\baseclass}

% ==============================================================================
% Package Imports
% ==============================================================================
% Load general packages that are used across multiple modules
\input{\classPath/Imports}

% ==============================================================================
% Module Includes
% ==============================================================================
\input{\classPath/Pages/Titlepage}
\input{\classPath/Pages/Bibliography}
\input{\classPath/Pages/Glossaries}

% ------------------------------------------------------------------------------
% Configuration Modules
% ------------------------------------------------------------------------------
\input{\classPath/Config/Hyperref}
%\input{\classPath/Config/Bibliography}
\input{\classPath/Config/Fonts}
\input{\classPath/Config/PageSetup}
\input{\classPath/Config/Sections}
%\input{\classPath/Config/GlossarySettings}
\input{\classPath/Config/ToC}
\input{\classPath/Config/Typography}
\input{\classPath/Config/PageBreakControl}
\input{\classPath/Config/CleverefNames}

% ------------------------------------------------------------------------------
% Content Modules
% ------------------------------------------------------------------------------
\input{\classPath/Modules/Content/Listings}

% ------------------------------------------------------------------------------
% Layout Modules
% ------------------------------------------------------------------------------
\input{\classPath/Modules/Layout/Logos}
\input{\classPath/Modules/Layout/InfoBlocks}
\input{\classPath/Modules/Layout/Watermark}

% ------------------------------------------------------------------------------
% Tool Modules
% ------------------------------------------------------------------------------
\input{\classPath/Modules/Tools/WordCount}

% ------------------------------------------------------------------------------
% Add Pages
% ------------------------------------------------------------------------------
\AtBeginDocument{
  \maketitle
  \newpage
  \setstretch{1.0}
  \pagestyle{tocpage}
 	\tableofcontents
  \newpage
  \pagestyle{scrheadings}
}
