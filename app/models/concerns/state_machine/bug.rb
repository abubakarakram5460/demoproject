module StateMachine
  module Bug
    extend ActiveSupport::Concern
    included do

      include AASM
        
        enum status: {
          newer: 0,
          started: 1,
          completed: 2,
          resolved: 3
        } 
        
          aasm column: :status, enum: true, whiny_tansitions: false do
          state :newer, initial: true
          state :started
          state :completed
          state :resolved

          event :set_next_state do
            transitions from: :newer , to: :started
          
            transitions from: :started, to: :completed, guard: :feature?
          
            transitions from: :started, to: :resolved, guard: :bug?
          end
        end  
    end
  end
end
        