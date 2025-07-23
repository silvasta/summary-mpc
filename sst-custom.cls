%-----------------------------------------------------------------
\ProvidesClass{sst-custom}
%-----------------------------------------------------------------
\LoadClass{article}
%-----------------------------------------------------------------
% General packages
%-----------------------------------------------------------------
\RequirePackage[document]{ragged2e}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[explicit]{titlesec}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{atbegshi}
\RequirePackage{booktabs}
\RequirePackage{calc}
\RequirePackage{caption}
\RequirePackage{csquotes}
\RequirePackage{float}
\RequirePackage{graphicx}
\RequirePackage{lipsum}
\RequirePackage{longtable}
\RequirePackage{mathtools}
\RequirePackage{multicol}
\RequirePackage{parskip}
\RequirePackage{pgffor}
\RequirePackage{siunitx}
\RequirePackage{subcaption}
\RequirePackage{tcolorbox}
%-----------------------------------------------------------------
% OPTIONS
%-----------------------------------------------------------------
\DeclareOption{landscape}{\PassOptionsToClass{landscape}{article}}
%-----------------------------------------------------------------
\newtoggle{use-tight} % Define toggle for tight option
\togglefalse{use-tight} % Default to false
\DeclareOption{tight}{\toggletrue{use-tight}}
\ProcessOptions\relax
%-----------------------------------------------------------------
% KEY-VALUE OPTIONS
%-----------------------------------------------------------------
\RequirePackage{kvoptions}
\RequirePackage{etoolbox} % For conditional logic
\SetupKeyvalOptions{
	family=myclass,
	prefix=myclass@
}
\DeclareStringOption[regular]{layout} % Default: regular
\DeclareStringOption[1]{columns}      % Default: 1 column
\DeclareStringOption[2]{secnumdepth}
\ProcessKeyvalOptions*
%-----------------------------------------------------------------
% Multicol and other toggle and settings
%-----------------------------------------------------------------
\newtoggle{do-multicol}
\ifnum\myclass@columns=1
	\togglefalse{do-multicol}
\else
	\toggletrue{do-multicol}
	\def\numcolumns{\myclass@columns}
\fi
%-----------------------------------------------------------------
\newtoggle{use-small-font}
\togglefalse{use-small-font}
%-----------------------------------------------------------------
% Section depth
%-----------------------------------------------------------------
\RequirePackage{sectsty}
\setcounter{secnumdepth}{\myclass@secnumdepth}
%-----------------------------------------------------------------
% LAYOUTS
%-----------------------------------------------------------------
% Regular
%-----------------------------------------------------------------
\ifdefstring{\myclass@layout}{regular}{
	\RequirePackage[
		paperheight=297mm,
		paperwidth=210mm,
		top=18mm,
		bottom=18mm,
		footskip=10mm,
		inner=18mm,
		outer=18mm,
		centering
	]{geometry}
	%-----------------------------------------------------------------
	\setlength{\columnsep}{11mm}
	%-----------------------------------------------------------------
}{}
%-----------------------------------------------------------------
% Summary
%-----------------------------------------------------------------
\ifdefstring{\myclass@layout}{summary}{
	%-----------------------------------------------------------------
	\RequirePackage[
		paperheight=210mm,
		paperwidth=297mm,
		top=1mm,
		bottom=1mm,
		inner=1mm,
		outer=1mm,
		centering
	]{geometry}
}{}
%-----------------------------------------------------------------
% Preview
%-----------------------------------------------------------------
\ifdefstring{\myclass@layout}{preview}{
	\RequirePackage[
		paperheight=210mm,
		% paperwidth=95mm, % Standard
		paperwidth=73.5mm, % fit tight 4col
		top=1mm,
		bottom=1mm,
		inner=1mm,
		outer=1mm,
		centering
	]{geometry}
}{}
%-----------------------------------------------------------------
% Chapter
%-----------------------------------------------------------------
\newcounter{Chapcounter}
\newcommand\showmycounter{\addtocounter{Chapcounter}{1}\themycounter}
% Add chapter functionality in article class
\iftoggle{use-tight}{
	\newcommand{\chapter}[1] {
		\addtocounter{Chapcounter}{1}{\large\textbf{~#1}}
		\addcontentsline{toc}{section}{#1}
	}}{
	% for non-tight chaptes
	\newcommand{\chapter}[1] {
		\addtocounter{Chapcounter}{1}{\Large\textbf{~#1}}
		\addcontentsline{toc}{section}{#1}
	}}
% %%% style ideas
% \addtocounter{Chapcounter}{1}\Large{\textbf{\color{RoyalBlue}#1}}
% \addcontentsline{toc}{section}{ \color{blue} Chapter:~\theChapcounter~~ #1}    
%-----------------------------------------------------------------
% TIGHT
%-----------------------------------------------------------------
\iftoggle{use-tight}{
	%-----------------------------------------------------------------
	\toggletrue{use-small-font}
	%-----------------------------------------------------------------
	\pagestyle{empty}
	%-----------------------------------------------------------------
	% \setlength{\headsep}{10mm}
	\setlength{\columnsep}{3mm}
	%-----------------------------------------------------------------
	\setlength{\intextsep}{0.2mm} % Space above/below in text
	\setlength{\textfloatsep}{0.2mm} % Space between floats
	\setlength{\floatsep}{0.2mm} % Space between floats
	%-----------------------------------------------------------------
	\setlength{\parindent}{0mm}
	\setlength{\parskip}{0mm}
	%-----------------------------------------------------------------
	\setlist{itemsep=0mm, topsep=0mm} % For all itemize/enumerate
	\setlist[itemize]{itemsep=0pt, leftmargin=3mm}
	\setlist[enumerate]{itemsep=0pt, leftmargin=4mm}
	%----------------------------------------------------------------
	% % spacing around eqns --nothing changed
	% \setlength{\abovedisplayskip}{0pt}
	% \setlength{\belowdisplayskip}{0pt}
	% \setlength{\abovedisplayshortskip}{0pt}
	% \setlength{\belowdisplayshortskip}{0pt}
	%----------------------------------------------------------------
	% changed less, maybe the 2.
	% \setlength{\mathsurround}{0pt}
	% \setlength{\jot}{0mm}
	% -----------------------------------------------------------------
	% space around title and fontsize
	% -----------------------------------------------------------------
	% \makeatother
	\renewcommand{\section}{\@startsection{section}{1}{\z@}
		{.5mm}% Space before
		{.5mm}% Space after
		{\normalfont\normalsize\bfseries}}
	\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
		{.25mm}%
		{.25mm}%
		{\normalfont\small\bfseries}}
	% \makeatother
	\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
		{.15mm}%
		{.15mm}%
		{\normalfont\footnotesize\bfseries}}
	% \makeatother
}{}
%-----------------------------------------------------------------
% FONT
%-----------------------------------------------------------------
\usepackage{fontspec}
% \usepackage[ngerman]{babel}
\usepackage[english]{babel}
% \babelfont{rm}{Lato}
% \babelfont{rm}{Roboto}
\babelfont{rm}{Roboto Condensed}
\babelprovide{ngerman}
%-----------------------------------------------------------------
% font of math
% \usepackage{lmodern} # default
% \usepackage{newtxmath}
% \usepackage{mathpazo}
\RequirePackage[ddmmyyyy]{datetime}
\renewcommand{\dateseparator}{.}
%-----------------------------------------------------------------
% color
\RequirePackage{soul}
% \sethlcolor{RoyalBlue}%!90}
\sethlcolor{BrickRed}%!90}
\definecolor{hltext}{rgb}{256,256,256}
%-----------------------------------------------------------------
% Custom commands
%-----------------------------------------------------------------
\newcommand{\T}{^\textnormal{\scriptsize T}}
\DeclareMathOperator{\argmin}{argmin}
%-----------------------------------------------------------------
% Theorem styles
%-----------------------------------------------------------------
\RequirePackage{amsthm}
\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newtheorem{theorem}{Theorem}
\newtheorem{proposition}{Proposition}
\newtheorem{corollary}{Corollary}
\newtheorem{remark}{Remark}
\newtheorem{lemma}{Lemma}

