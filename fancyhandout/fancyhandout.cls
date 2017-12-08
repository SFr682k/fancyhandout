%%	This is file 'fancyhandout.cls', Version 2017-12-08
%%	Copyright 2017 Sebastian Friedl <sfr682k@t-online.de>
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


\ProvidesClass{fancyhandout}[2017/12/08 fancyhandout development version]



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

%\RequirePackage{tikz}



% FONT SETTINGS ----------------------------------------------------------------------------------------------

% As long as not specified otherwise, use the sans-serif font by default
\if@sffont    \def\familydefault{\sfdefault}
\fi



% (RE-)DEFINE COMMANDS ---------------------------------------------------------------------------------------

% TODO: Redefine \section etc.
% TODO: Beamer styled boxes!!