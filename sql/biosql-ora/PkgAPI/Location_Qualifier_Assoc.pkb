--
-- API Package Body for Location_Qualifier_Assoc.
--
-- Scaffold auto-generated by gen-api.pl (H.Lapp, 2002).
--
-- $Id: Location_Qualifier_Assoc.pkb,v 1.1.1.2 2003-01-29 08:54:38 lapp Exp $
--

--
-- (c) Hilmar Lapp, hlapp at gnf.org, 2002.
-- (c) GNF, Genomics Institute of the Novartis Research Foundation, 2002.
--
-- You may distribute this module under the same terms as Perl.
-- Refer to the Perl Artistic License (see the license accompanying this
-- software package, or see http://www.perl.com/language/misc/Artistic.html)
-- for the terms under which you may use, modify, and redistribute this module.
-- 
-- THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
-- WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
-- MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
--

CREATE OR REPLACE
PACKAGE BODY LocOntA IS

CURSOR LocOntA_c (
		LocOntA_LOC_OID	IN SG_LOCATION_QUALIFIER_ASSOC.LOC_OID%TYPE,
		LocOntA_ONT_OID	IN SG_LOCATION_QUALIFIER_ASSOC.ONT_OID%TYPE)
RETURN SG_LOCATION_QUALIFIER_ASSOC%ROWTYPE IS
	SELECT t.* FROM SG_LOCATION_QUALIFIER_ASSOC t
	WHERE
		t.Loc_Oid = LocOntA_LOC_OID
	AND     t.Ont_Oid = LocOntA_ONT_OID
	;

FUNCTION get_oid(
		LOC_OID	IN SG_LOCATION_QUALIFIER_ASSOC.LOC_OID%TYPE DEFAULT NULL,
		ONT_OID	IN SG_LOCATION_QUALIFIER_ASSOC.ONT_OID%TYPE DEFAULT NULL,
		LocOntA_VALUE	IN SG_LOCATION_QUALIFIER_ASSOC.VALUE%TYPE DEFAULT NULL,
		Ont_NAME	IN SG_ONTOLOGY_TERM.NAME%TYPE DEFAULT NULL,
		Ont_CAT_OID	IN SG_ONTOLOGY_TERM.ONT_OID%TYPE DEFAULT NULL,
		Ont_IDENTIFIER	IN SG_ONTOLOGY_TERM.IDENTIFIER%TYPE DEFAULT NULL,
		FEA_OID		IN SG_SEQFEATURE_LOCATION.FEA_OID%TYPE DEFAULT NULL,
		Loc_RANK	IN SG_SEQFEATURE_LOCATION.RANK%TYPE DEFAULT NULL,
		do_DML		IN NUMBER DEFAULT BSStd.DML_NO)
RETURN INTEGER
IS
	pk	INTEGER DEFAULT NULL;
	LocOntA_row LocOntA_c%ROWTYPE;
	ONT_OID_	SG_ONTOLOGY_TERM.OID%TYPE DEFAULT ONT_OID;
	LOC_OID_	SG_SEQFEATURE_LOCATION.OID%TYPE DEFAULT LOC_OID;
BEGIN
	-- look up SG_ONTOLOGY_TERM
	IF (ONT_OID_ IS NULL) THEN
		ONT_OID_ := Ont.get_oid(
				Ont_NAME => Ont_NAME,
				Ont_CAT_OID => Ont_CAT_OID,
				Ont_IDENTIFIER => Ont_IDENTIFIER);
	END IF;
	-- look up SG_SEQFEATURE_LOCATION
	IF (LOC_OID_ IS NULL) THEN
		LOC_OID_ := Loc.get_oid(
				FEA_OID => FEA_OID,
				Loc_RANK => Loc_RANK);
	END IF;
	-- insert if requested (no update since no UK)
	IF (do_DML = BSStd.DML_I) OR (do_DML = BSStd.DML_UI) THEN
	    	-- look up foreign keys if not provided:
		-- look up SG_ONTOLOGY_TERM successful?
		IF (ONT_OID_ IS NULL) THEN
			raise_application_error(-20101,
				'failed to look up Ont <' || Ont_NAME || '|' || Ont_CAT_OID || '|' || Ont_IDENTIFIER || '>');
		END IF;
		-- look up SG_SEQFEATURE_LOCATION successful?
		IF (LOC_OID_ IS NULL) THEN
			raise_application_error(-20101,
				'failed to look up Loc <' || FEA_OID || '|' || Loc_RANK || '>');
		END IF;
	    	-- insert the record and obtain the primary key
	    	pk := do_insert(
			LOC_OID => LOC_OID_,
		        ONT_OID => ONT_OID_,
			VALUE => LocOntA_VALUE);
	END IF;
	-- return the primary key
	RETURN pk;
END;

FUNCTION do_insert(
		LOC_OID	IN SG_LOCATION_QUALIFIER_ASSOC.LOC_OID%TYPE,
		ONT_OID	IN SG_LOCATION_QUALIFIER_ASSOC.ONT_OID%TYPE,
		VALUE	IN SG_LOCATION_QUALIFIER_ASSOC.VALUE%TYPE)
RETURN INTEGER
IS
BEGIN
	-- insert the record
	INSERT INTO SG_LOCATION_QUALIFIER_ASSOC (
		LOC_OID,
		ONT_OID,
		VALUE)
	VALUES (LOC_OID,
		ONT_OID,
		VALUE)
	;
	-- return TRUE
	RETURN 1;
END;

END LocOntA;
/
