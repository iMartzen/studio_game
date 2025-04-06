require "minitest/autorun"

require_relative "../../lib/studio_game/auditable"

module StudioGame
  class AuditableTest < Minitest::Test
    class AuditableObject
      include Auditable
    end
    
    def setup
      @auditable = AuditableObject.new
      $stdout = StringIO.new
    end
    
    def teardown
      $stdout = STDOUT
    end
    
    def test_audit_outputs_rolled_number
      @auditable.audit(5)
      assert_equal "Audit: Rolled a 5\n", $stdout.string
    end
  end
end