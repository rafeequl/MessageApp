require 'spec_helper'

describe Message do
  it { should have(1).error_on(:user_id) }
  it { should have(1).error_on(:conversation_id) }
  it { should have(1).error_on(:body) }
end
