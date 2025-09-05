require 'yaml'
require 'fileutils'

module CalibreUniversal
  include RBA

  CONFIG_FILE_PATH = File.join(__dir__, "CalibreDRCConfig.yml")
  
  # Load configuration from a YAML file
  def self.load_config(file_path)
    File.exist?(file_path) ? YAML.load_file(file_path) : {}
  end

  # Export the current layout (GDS) to a temporary file
  def self.export_layout(result_path)
    app = RBA::Application.instance
    layout_view = app.main_window.current_view
    raise "No layout is open in KLayout." unless layout_view

    cellview = layout_view.cellview(layout_view.active_cellview_index)
    layout = cellview.layout
    raise "No layout found in the current cellview." unless layout

    top_cell = layout.top_cell
    raise "No top cell found." unless top_cell

    gds_path = File.join(result_path, "exported_layout.gds")
    if cellview.is_dirty?
      layout.write(gds_path)
    elsif cellview.filename && File.exist?(cellview.filename)
      FileUtils.cp(cellview.filename, gds_path)
    else
      layout.write(gds_path)
    end

    ENV["LAYOUT_GDS"] = gds_path
    ENV["TOPCELL_NAME"] = top_cell.name
    return gds_path, top_cell.name
  end

  # ===============================
  # Show Errors and Warnings
  # ===============================
  def self.show_errors_if_exist(result_path)
    errors_file = File.join(result_path, "errors_and_warnings")
    return unless File.exist?(errors_file)

    app = RBA::Application.instance
    mw  = app.main_window
    
    erros_box = RBA::MessageBox.question("Question", "Show errors and warnings?", RBA::MessageBox::Yes + RBA::MessageBox::No)
    
    if erros_box == RBA::MessageBox::Yes
      text_dialog = RBA::QDialog.new(mw)
      text_dialog.windowTitle = "Errors and Warnings"
      text_layout = RBA::QVBoxLayout.new(text_dialog)
      text_view = RBA::QTextEdit.new
      text_view.setReadOnly(true)
      text_layout.addWidget(text_view)

      text_view.setPlainText(File.read(errors_file))
      text_dialog.resize(1000, 600)
      text_dialog.exec
    end

  end
end
