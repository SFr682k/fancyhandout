%%	This is file 'fancyhandout.cls', Version 2018-01-22
%%	Copyright 2017-18 Sebastian Friedl <sfr682k@t-online.de>
%% 
%%	This work may be distributed and/or modified under the conditions of the LaTeX Project
%%	Public License, either version 1.3c of this license or (at your option) any later version.
%%	The latest version of this license is available at
%%		http://www.latex-project.org/lppl.txt
%%	and version 1.3c or later is part of all distributions of LaTeX version 2008-05-04 or later.
%%
%%	This work has the LPPL maintenance status 'maintained'.
%%	Author: Sebastian Friedl
%%	Current maintainer of this work is Sebastian Friedl
%%
%%	This work consists of the files fancyhandout.cls and fancyhandout-doc.tex
%%
%%	---------------------------------------------------------------------------------------------------------------------------------------------
%%
%%	A LaTeX class for producing nice-looking handouts.
%%
%%	---------------------------------------------------------------------------------------------------------------------------------------------
%%
%%	Please report bugs and other problems as well as suggestions for improvements to the following email address: sfr682k@t-online.de
%%
%%	--------------------------------------------------------------------------------------------------------------------------------------------- 


\ProvidesClass{fancyhandout}[2018/01/22 fancyhandout: A LaTeX class for producing nice-looking handouts]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{etoolbox}



% DEFINE OPTIONS ---------------------------------------------------------------------------------------------

% Option for using letter paper
\newif\if@letter
\@letterfalse
\DeclareOption{letter}{\@lettertrue}

% Option for one-sided layout
\newif\if@twoside
\@twosidetrue
\DeclareOption{oneside}{\@twosidefalse}

% Option for 10pt or 12pt font size
\newif\if@tenpt
\newif\if@twelvept
\@tenptfalse
\@twelveptfalse
\DeclareOption{10pt}{\@tenpttrue}
\DeclareOption{12pt}{\@twelvepttrue}

% Option for using the roman font as text font
\newif\if@sffont
\@sffonttrue
\DeclareOption{rmfont}{\@sffontfalse}

\ProcessOptions



% LOAD "article" ---------------------------------------------------------------------------------------------

% Pass font size to article
\if@tenpt           \PassOptionsToClass{10pt}{article}
\else\if@twelvept   \PassOptionsToClass{12pt}{article}
\else               \PassOptionsToClass{11pt}{article}
\fi\fi

% If not specified otherwise, use twoside layout
\if@twoside         \PassOptionsToClass{twoside}{article}
\fi

% All options specified. Load article.
\LoadClass{article}

% Set \parindent to zero
\parindent 0pt



% REQUIRE "geometry" -----------------------------------------------------------------------------------------

% If not specified otherwise, use twoside layout
\if@twoside \PassOptionsToPackage{twoside}{geometry}
\fi

% Page size
\if@letter	\PassOptionsToPackage{letterpaper}{geometry}
\else		\PassOptionsToPackage{a4paper}{geometry}
\fi

% Default page margins
\PassOptionsToPackage{left=2.25cm, right=2.25cm, top=2.25cm, bottom=2.25cm, includehead, includefoot}{geometry}

% All options specified. Load geometry.
\RequirePackage{geometry}



% REQUIRE OTHER PACKAGES -------------------------------------------------------------------------------------

\AtEndPreamble{\RequirePackage{csquotes}}

\RequirePackage{enumitem}
	\setlist{itemsep=0ex,topsep=.75ex}

\RequirePackage{fancyhdr}
	\pagestyle{fancy}
	\fancyhead{}
	\fancyfoot{}
	\if@twoside%
		\fancyhead[ro,le]{%
			\def\and{\unskip,~}%
			\insertshortauthor%
			\ifx\insertshorttitle\@empty\else\ifx\insertshortauthor\@empty\else :~\fi\fi%
			\insertshorttitle}
		\fancyfoot[ro,le]{\thepage}
		\fancyfoot[re,lo]{\insertshortdate}
	\else
		\fancyhead[r]{%
			\def\and{\unskip,~}
			\insertshortauthor%
			\ifx\insertshorttitle\@empty\else\ifx\insertshortauthor\@empty\else :~\fi\fi%
			\insertshorttitle}
		\fancyfoot[l]{\insertshortdate}
		\fancyfoot[r]{\thepage}
	\fi
	\def\footrulewidth{0.4pt}
	\headheight=14pt

% Required when hyperref is not loaded by the user
% This "fake command" gets redefined when hyperref is loaded
\ifx\phantomsection\@undefined	\let\phantomsection\@empty	\fi
% Also, write the document information to hyperref when loaded
\AtBeginDocument{%
	\ifx\hypersetup\@undefined\else%
		\hypersetup{pdftitle=\inserttitle,pdfauthor=\insertauthor,pdfcreator={LaTeX with fancyhandout class}}%
	\fi}



% COLOR SETTINGS ---------------------------------------------------------------------------------------------

\RequirePackage{xcolor}

% Basic color
\definecolor{fancyhandoutblue}{rgb}{0.2,0.2,0.7}

% Initial definition of a primary and a secondary color
\colorlet{fancyhandoutmaincolor}{fancyhandoutblue}
\colorlet{fancyhandoutsecondarycolor}{fancyhandoutblue!85}

% Line colors
\colorlet{fancyhandoutsectlinecolor}{fancyhandoutmaincolor}
\colorlet{fancyhandoutsubsectlinecolor}{fancyhandoutsecondarycolor}

% Title box colors
\colorlet{fancyhandouttboxlinecolor}{fancyhandoutmaincolor}
\colorlet{fancyhandouttboxfillcolor}{fancyhandoutmaincolor!12.5}



% FONT SETTINGS ----------------------------------------------------------------------------------------------

% As long as not specified otherwise, use the sans-serif font by default
\if@sffont    \def\familydefault{\sfdefault}
\fi



% TITLE COMMANDS ---------------------------------------------------------------------------------------------

% Redefine the provided commands and define beamer-like commands inserting their values
\def\title{}
\let\inserttitle\@empty
\let\insertshorttitle\@empty
%
\def\subtitle{}
\let\insertsubtitle\@empty
\let\insertshortsubtitle\@empty
%
\def\author{}
\let\insertauthor\@empty
\let\insertshortauthor\@empty
\let\and\@empty
%
\def\institute{}
\let\insertinstitute\@empty
\let\insertshortinstitute\@empty
%
\def\date{}
\let\insertdate\today
\let\insertshortdate\today

% Set the according variable when a command is used
\renewcommand{\title}[2][\inserttitle]{%
	\def\inserttitle{#2}%
	\def\insertshorttitle{#1}}
\renewcommand{\subtitle}[2][\insertsubtitle]{%
	\def\insertsubtitle{#2}%
	\def\insertshortsubtitle{#1}}
\renewcommand{\author}[2][\insertauthor]{%
	\def\insertauthor{#2}%
	\def\insertshortauthor{#1}}
\renewcommand{\institute}[2][\insertinstitute]{%
	\def\insertinstitute{#2}
	\def\insertshortinstitute{#1}}
\renewcommand{\date}[2][\insertdate]{%
	\def\insertdate{#2}%
	\def\insertshortdate{#1}}

% Typesets a title box
\def\maketitle{%
	\def\and{\qquad}%
	\thispagestyle{empty}
	\begin{center}
		\fcolorbox{fancyhandouttboxlinecolor}{fancyhandouttboxlinecolor}{%
			\fcolorbox{fancyhandouttboxlinecolor}{fancyhandouttboxfillcolor}{%
				\parbox{.95\textwidth}{\centering\vspace{\medskipamount}%
					\ifx\inserttitle\@empty\else {\LARGE\bfseries\inserttitle} \\[\smallskipamount] \fi
					\ifx\insertsubtitle\@empty\else {\large\insertsubtitle} \\ \fi
					\vspace{\medskipamount}\small
					\ifx\insertauthor\@empty\else \insertauthor \ifx\insertinstitute\@empty \\[\medskipamount] \else \\ \fi\fi
					\ifx\insertinstitute\@empty\else \insertinstitute \\[\medskipamount] \fi
					\insertdate
				\vspace{\medskipamount}}}}%
	\end{center}\smallskip}



% SECTION COMMANDS -------------------------------------------------------------------------------------------

% TOC (Pt. I):  Add some space below
\let\origtableofcontents\tableofcontents
\def\tableofcontents{%
	\origtableofcontents%
	\vskip 1.5\bigskipamount}

% TOC (Pt. II): No numbering of sections and subsections
\renewcommand{\numberline}[1]{}

% Own \section command
\def\fancysection#1{%
	\vskip 2\bigskipamount% \vskip, not \vspace; starts a new paragraph
	\noindent%
	\begin{minipage}{\textwidth}%
	{\Large\bfseries%
		#1}\vskip -1ex%
	{\color{fancyhandoutsectlinecolor}\rule{\textwidth}{3pt}}
	\end{minipage}
	\vskip \bigskipamount%
}

% Own \subsection command
\def\fancysubsection#1{%
	\vskip 1.25\bigskipamount%
	\noindent%
	\begin{minipage}{\textwidth}%
	{\large\bfseries%
		#1}\vskip -1.25ex%
	{\color{fancyhandoutsubsectlinecolor}\rule{\textwidth}{1.5pt}}
	\end{minipage}
	\vskip \medskipamount%
}

% Own \subsubsection command
\def\fancysubsubsection#1{%
	\vskip .75\bigskipamount% \vskip, not \vspace; starts a new paragraph
	\noindent%
	\begin{minipage}{\textwidth}%
	{\bfseries%
		#1}%
	\end{minipage}
	\vskip .75\smallskipamount%
}

% Redefine article's sectioning commands
\def\section{\@ifstar\@@section\@section}
\def\@section#1{%
	\phantomsection%
	\refstepcounter{section}%
	\def\@currentlabel{\enquote{#1}}% Manipulate LaTeX's internal mechanisms to print the section name when using \ref >:)
	\addcontentsline{toc}{section}{#1}%
	\@@section{#1}}
\def\@@section#1{\fancysection{#1}}

\def\subsection{\@ifstar\@@subsection\@subsection}
\def\@subsection#1{%
	\phantomsection%
	\refstepcounter{subsection}%
	\def\@currentlabel{\enquote{#1}}%
	\addcontentsline{toc}{subsection}{#1}%
	\@@subsection{#1}}
\def\@@subsection#1{\fancysubsection{#1}}

\def\subsubsection{\@ifstar\@@subsubsection\@subsubsection}
\def\@subsubsection#1{%
	\phantomsection%
	\refstepcounter{subsubsection}%
	\def\@currentlabel{\enquote{#1}}%
	\addcontentsline{toc}{subsubsection}{#1}%
	\@@subsubsection{#1}}
\def\@@subsubsection#1{\fancysubsubsection{#1}}



% OTHER TODOS ------------------------------------------------------------------------------------------------


% TODO: Beamer styled boxes!!
