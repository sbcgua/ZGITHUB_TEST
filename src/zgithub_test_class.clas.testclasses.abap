
class ltcl_Test definition for testing
  duration short
  risk level harmless.

  private section.
* ================
    data:
      f_Cut type ref to zgithub_Test_Class.  "class under test

    methods: test for testing.
endclass.       "ltcl_Test


class ltcl_Test implementation.
* ===============================

  method test.
* ============

    f_Cut->test(  ).
  endmethod.       "test

endclass.       "ltcl_Test
