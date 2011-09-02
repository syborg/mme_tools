# mme_tools/concurrent
# Marcel Massana 1-Sep-2011

require 'thread'

module MMETools

  # Concurrent classes (some method converted to concurrent versions)
  module Concurrent

    class ConcurrentHash < Hash

      def initialize
        super
        @mutex = Mutex.new
      end

      def [](*args)
        @mutex.synchronize { super }
      end

      def []=(*args)
        @mutex.synchronize { super }
      end
    end

    class ConcurrentArray < Array

      def initialize
        super
        @mutex = Mutex.new
      end

      def [](*args)
        @mutex.synchronize { super }
      end

      def []=(*args)
        @mutex.synchronize { super }
      end

      def <<(*args)
        @mutex.synchronize { super }
      end

    end

  end

end
