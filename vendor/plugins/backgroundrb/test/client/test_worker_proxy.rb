require File.join(File.dirname(__FILE__) + "/../bdrb_test_helper")
require File.join(File.dirname(__FILE__) + "/../bdrb_client_test_helper")

context "Worker Proxy in general" do
  setup do
    BDRB_CONFIG.set({:schedules=> {
                        :foo_worker => { :barbar=>{:trigger_args=>"*/5 * * * * * *"}}},
                      :backgroundrb=>{:port=>11008, :ip=>"0.0.0.0", :environment=> "production"}
                    })

    @cluster_conn = mock
    @worker_proxy = BackgrounDRb::RailsWorkerProxy.new(:hello_worker,nil,@cluster_conn)
  end
  specify "should let you fetch results" do
    @cluster_conn.expects(:backend_connections).returns([])
    foo = @worker_proxy.ask_result(:foobar)
    foo.should.be nil
  end

  specify "should let you invoke sync task  methods" do
    actual_conn = mock()
    actual_conn.expects(:server_info).returns("localhost:11008")
    actual_conn.expects(:send_request).returns(20)
    @cluster_conn.expects(:choose_server).returns(actual_conn)
    a = @worker_proxy.hello_world(:args => "sucks")
    a.should == 20
  end

  specify "should let you invoke delete method" do
    actual_conn = mock()
    actual_conn.expects(:delete_worker).with(:worker => :hello_worker).returns(nil)
    @cluster_conn.expects(:backend_connections).returns(Array(actual_conn))
    @worker_proxy.delete
  end

  specify "delete method should run on all nodes" do
  end

  specify "should let you invoke worker_info method" do
    backend_connections = []
    2.times { |i|
      actual_conn = mock()
      actual_conn.expects(:worker_info).with(:worker => :hello_worker).returns(i)
      backend_connections << actual_conn
    }
    @cluster_conn.expects(:backend_connections).returns(backend_connections)
    a = @worker_proxy.worker_info
    a.should == [0,1]
  end

  specify "should let you run async tasks" do
    actual_conn = mock()
    actual_conn.expects(:ask_work).with(:arg => :hello,:worker => :hello_worker,:worker_method => 'foobar',:job_key => 'boy').returns(nil)
    @cluster_conn.expects(:find_connection).returns(actual_conn)
    @worker_proxy.async_foobar(:arg => :hello,:job_key => "boy",
                               :host => "192.168.2.100:100")

  end
end
