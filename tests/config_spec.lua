describe("config", function()
  it("has default values after set()", function()
    local config = require "terminal.config"

    config.set()

    assert.equal(true, config.options.startinsert)
  end)

  it("has new values with custom config", function()
    local config = require "terminal.config"

    config.set {
      startinsert = false,
    }

    assert.equal(false, config.options.startinsert)
  end)
end)
