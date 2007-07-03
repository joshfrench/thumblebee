namespace :svn do
  
  desc "Configure Subversion for Rails"
  task :configure do
    system "svn remove log/*"
    system "svn commit -m 'removing all log files from subversion'"
    system 'svn propset svn:ignore "*.log" log/'
    system "svn update log/"
    system "svn commit -m 'Ignoring all files in /log/ ending in .log'"
    system "svn remove tmp/*"
    system "svn commit -m 'Removing /tmp/ folder'"
    system 'svn propset svn:ignore "*" tmp/'
  end
  
  task :config => :configure

  
  desc "Adds all files with an svn status flag of '?'" 
  task :add do
    system "svn status | grep '^\?' | sed -e 's/? *//' | sed -e 's/ /\ /g' | xargs svn add"
  end
  
  desc "Removes all files with an svn status flag of '!'" 
  task :remove do
    system "svn status | grep '^\!' | sed -e 's/! *//' | sed -e 's/ /\ /g' | xargs svn rm"
  end

end