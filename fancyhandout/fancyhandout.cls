%%	This is file 'fancyhandout.cls', Version 2017-01-18
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
%%	This class and its documentation are currently under construction.
%%	Commands, options and behaviour may change with future versions of the class.
%%
%%	---------------------------------------------------------------------------------------------------------------------------------------------
%%
%%	Please report bugs and other problems as well as suggestions for improvements to the following email address: sfr682k@t-online.de
%%
%%	--------------------------------------------------------------------------------------------------------------------------------------------- 


\ProvidesClass{fancyhandout}[2018/01/18 fancyhandout development version]



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

% TODO: Load fancyhdr

\RequirePackage{enumitem}
	\setlist{itemsep=0ex,topsep=.75ex}


\RequirePackage{xcolor}

%\RequirePackage{tikz}



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
\def\and{\qquad}
%
\def\date{}
\let\insertdate\@empty
\let\insertshortdate\@empty

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
\renewcommand{\date}[2][\insertdate]{%
	\def\insertdate{#2}%
	\def\insertshortdate{#1}}

% TODO: Provide something to display the institute
\def\maketitle{%
	\thispagestyle{empty}
	\begin{center}
		\fcolorbox{black}{blue}{\fcolorbox{black}{blue!10}{%
			\parbox{.95\textwidth}{\centering\vspace{\medskipamount}%
				\ifx\inserttitle\@empty\else {\LARGE\bfseries\inserttitle} \\[\medskipamount] \fi
				\ifx\insertsubtitle\@empty\else {\large\insertsubtitle} \\ \fi
				\vspace{\medskipamount}\small
				\ifx\insertauthor\@empty\else \insertauthor \\[\medskipamount] \fi
				\insertdate
		\vspace{\medskipamount}}}}%
	\end{center}\smallskip}



% SECTION COMMANDS -------------------------------------------------------------------------------------------

% Own \section command
\def\fancysection#1{%
	\vskip 2\bigskipamount% \vskip, not \vspace; starts a new paragraph
	\noindent%
	\begin{minipage}{\textwidth}%
	{\Large\bfseries%
		#1}\vskip -1ex%
	{\color{blue}\rule{\textwidth}{3pt}}
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
	{\color{blue!70}\rule{\textwidth}{1.5pt}}
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
	% TODO: Add toc-entry and hyperref bookmark
	\@@section{#1}}
\def\@@section#1{\fancysection{#1}}

\def\subsection{\@ifstar\@@subsection\@subsection}
\def\@subsection#1{%
	% TODO: Add toc-entry and hyperref bookmark
	\@@subsection{#1}}
\def\@@subsection#1{\fancysubsection{#1}}

\def\subsubsection{\@ifstar\@@subsubsection\@subsubsection}
\def\@subsubsection#1{%
	% TODO: Add toc-entry and hyperref bookmark
	\@@subsubsection{#1}}
\def\@@subsubsection#1{\fancysubsubsection{#1}}



% LEFT TODOS -------------------------------------------------------------------------------------------------


% TODO: Beamer styled boxes!!