--
-- SQL script to create the trigger(s) enabling the load API for
-- SGLD_Bioentry_Ref_Assocs.
--
-- Scaffold auto-generated by gen-api.pl.
--
--
-- $Id: Bioentry_Ref_Assocs.trg,v 1.1.1.1 2002-08-13 19:51:10 lapp Exp $
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

CREATE OR REPLACE TRIGGER BIUR_Bioentry_Ref_Assocs
       INSTEAD OF INSERT OR UPDATE
       ON SGLD_Bioentry_Ref_Assocs
       REFERENCING NEW AS new OLD AS old
       FOR EACH ROW
DECLARE
	pk		SG_BIOENTRY_REF_ASSOC.ENT_OID##FIXME##REF_OID##FIXME##RANK%TYPE DEFAULT :new.EntRefA_Oid;
	do_DML		INTEGER DEFAULT BSStd.DML_NO;
BEGIN
	IF INSERTING THEN
		do_DML := BSStd.DML_I;
	ELSE
		-- this is an update
		do_DML := BSStd.DML_UI;
	END IF;
	-- do insert or update (depending on whether it exists or not)
	pk := EntRefA.get_oid(
			EntRefA_ENT_OID##FIXME##REF_OID##FIXME##RANK => pk,
		        EntRefA_REF_OID => REF_OID_,
			EntRefA_RANK => EntRefA_RANK,
			EntRefA_END_POS => EntRefA_END_POS,
			EntRefA_START_POS => EntRefA_START_POS,
			do_DML             => do_DML);
END;
/