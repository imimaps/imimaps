class QuicksearchesController < ApplicationController

	def index

		@quicksearch = Quicksearch.new

    @companies = []

    @orientations_ary = []

    @language_ary = []

    if params[:orientation].nil? and params[:semester].nil? and params[:programming_language_ids].nil? and params[:country].nil?
      @internships = Internship.order("created_at DESC") 
    else
      @internships = @quicksearch.internships(params)
    end

    @companies = @internships.collect do |x| x.company end
    @orientations_ary = @internships.collect do |x| x.orientation.name end

    @internships.each do |i|
      i.programming_languages.each do |p|
        @language_ary << p
      end
    end

		@pins = @companies.to_gmaps4rails do |company, marker |
      href =  if company.website.starts_with?'http' 
                company.website  
              else 
                "http://"+company.website 
              end
      marker.infowindow ("<a href='/companies/#{company.id}' style='font-weight:bold'>#{company.name}</a><p>Industry: #{company.industry}</p><p>Employees: #{company.number_employees}</p><a href='#{href}' target='_blank'>#{company.website}</a>")

    end

    ids = @internships.collect do |x| x.id end

    @semesters = @internships.collect do |x| x.semester end.map do |s|[s.semester,s.id] end

    @programming_languages = language_ary.uniq.map do |p|[p.name, p.id] end

    @internships_size = @internships.size

    @bool = Internship.all.size == @internships_size

    @countries = (@companies.collect do |x| x.country end)

    @orientations = orientations_ary.uniq

    countries_uniq = @countries.uniq
    ary = Array.new
    countries_uniq.each do |x|
      ary << {:name=>x, :count=>@countries.count(x)}
    end
    @data_country = ary

    language_uniq = @language_ary.uniq
    ary = Array.new
    language_uniq.each do |x|
      ary << {:name=>x, :count=>(@language_ary.count(x).to_f/@internships_size*100).to_i}
    end
    @data_language = ary

    orientation_uniq = @orientations_ary.uniq
    ary = Array.new
    orientation_uniq.each do |x|
      ary << {:name=>x, :count=>@orientations_ary.count(x)}
    end
    @data_orientation = ary

    @countries = @countries.uniq

    respond_to do |format|
      format.js { render :layout=>false, :locals => { :pins  => @pins, :internships => @internships, :paginating => @paginating } }
    end
  end

end
