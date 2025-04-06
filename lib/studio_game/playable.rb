module Playable
  def boost
    self.health += 15
  end

  def drain
    self.health -= 10
  end
end